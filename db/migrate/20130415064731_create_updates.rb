class CreateUpdates < ActiveRecord::Migration
  def change
    create_table :ticket_updates do |t|
      t.integer :status_id
      t.integer :owner_id
      t.integer :updater_id
      t.integer :ticket_id
      t.integer :revision
      t.string :description
      t.integer :time_logged
      t.timestamps
    end
  end
end
