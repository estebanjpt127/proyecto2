class RemoveUserFromArticles < ActiveRecord::Migration[7.2]
  def change
    remove_column :articles, :user, :integer
  end
end
