class CreateThoughts < ActiveRecord::Migration[6.0]
  def change
    create_table :thoughts, id: :uuid do |t|
      t.string :name

      t.timestamps
    end
  end
end
