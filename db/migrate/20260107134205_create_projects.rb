class CreateProjects < ActiveRecord::Migration[8.1]
  def change
    create_table :projects do |t|
      t.references :lead, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :status
      t.string :svc_code
      t.datetime :approved_at
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :projects, :svc_code
  end
end
