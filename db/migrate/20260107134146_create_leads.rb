class CreateLeads < ActiveRecord::Migration[8.1]
  def change
    create_table :leads do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.text :address
      t.decimal :lat, precision: 10, scale: 6
      t.decimal :long, precision: 10, scale: 6
      t.string :status

      t.timestamps
    end
    add_index :leads, :email
  end
end
