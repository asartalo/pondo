class CreateLedgerSubscribers < ActiveRecord::Migration[5.0]
  def change
    create_table :ledger_subscribers do |t|
      t.references :user, foreign_key: true
      t.references :ledger, type: :uuid, foreign_key: true

      t.timestamps
    end

    add_index :ledger_subscribers, [:user_id, :ledger_id], unique: true
  end
end
