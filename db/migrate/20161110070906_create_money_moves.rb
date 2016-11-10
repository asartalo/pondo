class CreateMoneyMoves < ActiveRecord::Migration[5.0]
  def change
    create_table :money_moves, id: :uuid do |t|
      t.date :date, index: true
      t.decimal :amount, precision: 14, scale: 4
      t.text :notes
      t.string :type
      t.references :ledger, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
