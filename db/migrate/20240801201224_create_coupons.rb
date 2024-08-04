class CreateCoupons < ActiveRecord::Migration[7.1]
  def change
    create_table :coupons do |t|
      t.string :name
      t.string :unique_code
      t.float :percent_off, default: 0
      t.float :dollar_off, default: 0
      t.references :merchant, null: false, foreign_key: true

      t.timestamps
    end

    add_index :coupons, :unique_code, unique: true
  end
end
