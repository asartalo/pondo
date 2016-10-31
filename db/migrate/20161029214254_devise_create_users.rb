#
#  id         :integer          not null, primary key
#  name       :string           default(""), not null
#  email      :string           default(""), not null
#  provider   :string           default(""), not null
#  uid        :string           default(""), not null
#  image      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null

class DeviseCreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email,     null: false, default: ""
      t.string :name,      null: false, default: ""
      t.string :provider,  null: false, default: ""
      t.string :uid,       null: false, default: ""
      t.string :image,     null: false, default: ""

      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
  end
end
