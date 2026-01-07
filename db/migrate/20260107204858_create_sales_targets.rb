class CreateSalesTargets < ActiveRecord::Migration[8.1]
  def change
    create_table :sales_targets do |t|
      t.decimal :amount
      t.integer :month
      t.integer :year

      t.timestamps
    end
  end
end
