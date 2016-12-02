class AddIndexToShopsUrl < ActiveRecord::Migration[5.0]
  def change
  	add_index :shops, :url, unique: true
  end
end
