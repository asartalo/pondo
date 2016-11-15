class CreateMoneyMoveTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :money_move_types, id: :uuid do |t|
      t.references :ledger, type: :uuid, foreign_key: true
      t.references :category, type: :uuid, foreign_key: true
      t.string :name
      t.string :type

      t.timestamps
    end
  end
end
