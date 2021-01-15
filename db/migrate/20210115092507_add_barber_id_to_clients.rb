class AddBarberIdToClients < ActiveRecord::Migration[6.1]
  def change
    add_column :clients, :barber_id, :integer
    add_index :clients, :barber_id
  end
end
