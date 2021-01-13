require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require 'sqlite3'

set :database, { adapter: 'sqlite3', database: 'barbershop.db' }

class Client < ActiveRecord::Base
end

class Barber < ActiveRecord::Base
end

before do
  @barbers = Barber.all
end

get "/" do
  erb :index
end

get "/visit" do
  erb :visit
end

post "/visit" do
  @barber = params[:barber]
  @username = params[:username]
  @phone = params[:phone]
  @datetime = params[:datetime]
  @color = "undefined color"

  hh = { :username => "Введите Ваше имя",
    :phone => "Ввведите телефон",
    :datetime => "Введите дату",
    :barber => "Введите Парикмахера",
    :color => "Введите цвет прически"
  }

  if is_validation_valid? hh
    Client.create(name: @username, phone: @phone, datestamp: @datetime, barber: @barber, color: @color)
    erb "Вы успешно зарегистрированы! Ждем Вас #{@datestamp}"
  else
    erb :visit
  end
end

def is_validation_valid? hh
  @error = hh.select { |key| params[key] == "" }.values.join(", ")
  @error.length > 0 ? false : true
end