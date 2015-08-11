class AddCodeToHealthPosts < ActiveRecord::Migration
  def change
    add_column :health_posts, :code, :string
  end
end
