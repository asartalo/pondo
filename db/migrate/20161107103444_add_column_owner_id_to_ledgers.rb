class AddColumnOwnerIdToLedgers < ActiveRecord::Migration[5.0]
  def change
    add_reference :ledgers, :user, index: true
    add_foreign_key :ledgers, :users
  end
end
