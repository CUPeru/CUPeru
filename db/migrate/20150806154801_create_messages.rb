class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :body
      t.string :to
      t.string :from
      t.string :date_sent
      t.string :keyword

      t.timestamps null: false
    end
  end
end
