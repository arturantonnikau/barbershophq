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

class Contact < ActiveRecord::Base
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

get "/contacts" do
  erb :contacts
end

post "/contacts" do
  @name = params[:name]
  @email = params[:email]
  @textarea = params[:textarea]

  hh = { :name => "Введите имя",
         :email => "Введите email",
         :textarea => "Введите сообщение"
  }

  if is_validation_valid? hh
    Contact.create(name: @name, email: @email, message: @textarea)
    erb "Спасибо за оставленное сообщение"
  else
    erb :contacts
  end
end

get "/barber/:id" do
  @barber = @barbers.find(params[:id])
  erb :barber
end

get "/bookings" do
  @clients = Client.all
  erb :booking
end

def is_validation_valid? hh
  @error = hh.select { |key| params[key] == "" }.values.join(", ")
  @error.length > 0 ? false : true
end