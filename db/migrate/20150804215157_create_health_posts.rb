class CreateHealthPosts < ActiveRecord::Migration
  def change
    create_table :health_posts do |t|
      t.string :phone_number
      t.references :health_center, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
