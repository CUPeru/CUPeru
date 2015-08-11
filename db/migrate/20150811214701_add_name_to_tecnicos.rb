class AddNameToTecnicos < ActiveRecord::Migration
  def change
    add_column :tecnicos, :name, :string
  end
end
