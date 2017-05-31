class AddTypeColumnToMoneyMoves < ActiveRecord::Migration[5.0]
  def change
    add_reference :money_moves, :money_move_type, foreign_key: true, type: :uuid
  end
end
