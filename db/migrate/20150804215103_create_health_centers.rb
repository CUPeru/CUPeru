class CreateHealthCenters < ActiveRecord::Migration
  def change
    create_table :health_centers do |t|
      t.string :phone_number

      t.timestamps null: false
    end
  end
end
