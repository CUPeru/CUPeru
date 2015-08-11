class AddCodeToHealthCenters < ActiveRecord::Migration
  def change
    add_column :health_centers, :code, :string
  end
end
