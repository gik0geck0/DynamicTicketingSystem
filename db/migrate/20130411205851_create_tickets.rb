class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.integer :id
      t.string :name
      t.integer :owner_id
      t.integer :status_id
      t.string :description
      t.integer :creation_timestamp

      t.timestamps
    end
  end
end
