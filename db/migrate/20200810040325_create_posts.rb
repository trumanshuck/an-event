class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts, id: :uuid do |t|
      t.string :title
      t.text :content
      t.references :stop, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end
  end
end
