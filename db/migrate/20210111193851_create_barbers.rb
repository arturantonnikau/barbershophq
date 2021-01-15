class CreateBarbers < ActiveRecord::Migration[6.1]
  has_many :clients
  def change
    create_table :barbers do |t|
      t.text :name

      t.timestamps
    end
  end
end
