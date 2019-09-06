class AddUseridTo < ActiveRecord::Migration[5.2]
  def change

    add_reference :ratings, :user, foreign_key: true
    add_column :ratings, :comments, :string
 
  end
end
