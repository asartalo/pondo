class CreateSubscriptions < ActiveRecord::Migration[5.1]
  def change
    enable_extension 'pgcrypto'
    create_table :subscriptions, id: :uuid do |t|
      t.string :email
      t.boolean :done
      t.references :ledger, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
