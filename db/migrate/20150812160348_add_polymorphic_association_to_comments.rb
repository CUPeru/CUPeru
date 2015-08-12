class AddPolymorphicAssociationToComments < ActiveRecord::Migration
  def change
    change_table :messages do |t|
      t.references :messageable, :polymorphic => true
    end
  end
end
