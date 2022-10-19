class RenameColumnOnPosts < ActiveRecord::Migration[7.0]
  def change
    rename_column :posts, :body, :content
  end
end
