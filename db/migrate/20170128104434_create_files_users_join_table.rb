class CreateFilesUsersJoinTable < ActiveRecord::Migration[5.0]
  def change
    create_table :users_dist_files do |t|
      t.integer :user_id
      t.integer :dist_file_id
    end
  end
end
