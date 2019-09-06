class RemoveForeignkey < ActiveRecord::Migration[5.2]
  def change
  	change_table :ratings do |t|
               remove_column :ratings, :user_id

      end
  end
end
