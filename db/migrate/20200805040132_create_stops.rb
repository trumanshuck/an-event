class CreateStops < ActiveRecord::Migration[6.0]
  def change
    create_table :stops, id: :uuid do |t|
      t.string :name
      t.datetime :from
      t.datetime :to
      t.float :lat
      t.float :lng
    end
  end
end
