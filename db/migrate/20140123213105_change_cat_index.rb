class ChangeCatIndex < ActiveRecord::Migration
  def change
    remove_index :cats, :user_id

    add_index :cats, :user_id
  end
end
