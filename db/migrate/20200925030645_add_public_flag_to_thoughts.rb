class AddPublicFlagToThoughts < ActiveRecord::Migration[6.0]
  def change
    add_column :thoughts, :public, :boolean, default: true
  end
end
