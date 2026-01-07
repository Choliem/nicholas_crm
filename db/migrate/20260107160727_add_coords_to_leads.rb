class AddCoordsToLeads < ActiveRecord::Migration[8.1]
  def change
    add_column :leads, :lat, :decimal, precision: 10, scale: 6
    add_column :leads, :long, :decimal, precision: 10, scale: 6
  end
end
