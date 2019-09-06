class AddColumnNameTo < ActiveRecord::Migration[5.2]
  def change
  	add_column :ratings, :user_name, :integer
  end
end

