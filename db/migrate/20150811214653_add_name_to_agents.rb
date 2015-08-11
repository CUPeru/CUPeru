class AddNameToAgents < ActiveRecord::Migration
  def change
    add_column :agents, :name, :string
  end
end
