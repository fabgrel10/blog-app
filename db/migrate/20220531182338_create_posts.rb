class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :text
      t.integer :comments_counter, null: false, default: 0
      t.integer :likes_counter, null: false, default: 0
      t.references :author, index: true, foreign_key: { to_table: :users, on_delete: :cascade, null: false }

      t.timestamps
    end
  end
end
