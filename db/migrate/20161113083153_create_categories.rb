class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories, id: :uuid do |t|
      t.string :type
      t.string :name
      t.text   :description
      t.references :ledger, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
