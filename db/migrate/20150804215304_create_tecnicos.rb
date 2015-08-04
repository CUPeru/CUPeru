class CreateTecnicos < ActiveRecord::Migration
  def change
    create_table :tecnicos do |t|
      t.string :phone_number
      t.references :health_post, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
