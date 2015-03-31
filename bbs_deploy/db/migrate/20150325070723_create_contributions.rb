class CreateContributions < ActiveRecord::Migration
  def change
    create_table :contributions do |t|
      t.string :name
      t.text :body
      t.integer :good
      t.string :img
    end
  end
end
