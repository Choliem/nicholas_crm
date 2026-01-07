class CreateProjects < ActiveRecord::Migration[8.1]
  def change
    create_table :projects do |t|
      t.references :lead, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.string :status
      t.datetime :approved_at

      t.timestamps
    end
  end
end
