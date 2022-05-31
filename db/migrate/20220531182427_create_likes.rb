class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.references :author, index: true, foreign_key: { to_table: :users, on_delete: :cascade, null: false }
      t.references :post, index: true, foreign_key: { on_delete: :cascade, null: false }

      t.timestamps
    end
  end
end
