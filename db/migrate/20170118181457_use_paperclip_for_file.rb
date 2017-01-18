class UsePaperclipForFile < ActiveRecord::Migration[5.0]
  def up
    add_attachment :dist_files, :attached
  end

  def down
    remove_attachment :dist_files, :attached
  end
end
