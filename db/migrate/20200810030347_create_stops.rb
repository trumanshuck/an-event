class CreateStops < ActiveRecord::Migration[6.0]
  def change
    create_table :stops, id: :uuid do |t|
      t.string :name
      t.date :from
      t.date :to
      t.decimal :lat
      t.decimal :lng
      t.string :slug

      t.timestamps
    end
  end
end
