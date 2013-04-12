class RenameTicketOwnerToUser < ActiveRecord::Migration
  def change
    rename_column :tickets, :owner_id, :user_id
  end
end
