class CreateOptions < ActiveRecord::Migration[8.1]
  def change
    create_table :options do |t|
      t.string :name
      t.string :description
      t.decimal :price
      t.string :status
      t.string :created_by
      t.string :updated_by
      t.references :menu, null: false, foreign_key: true

      t.timestamps
    end
  end
end
