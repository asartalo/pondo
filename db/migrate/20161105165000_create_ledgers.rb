class CreateLedgers < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'pgcrypto'
    # enable_extension 'uuid-ossp'
    create_table :ledgers, id: :uuid do |t|
      t.string :name
      t.string :currency
      t.integer :savings_target

      t.timestamps
    end
  end
end
