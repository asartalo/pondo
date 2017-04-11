class CreateCountryCurrencies < ActiveRecord::Migration[5.0]
  def change
    create_table :country_currencies do |t|
      t.string :country_code, index: true
      t.string :currency, index: true

      t.timestamps
    end
  end
end
