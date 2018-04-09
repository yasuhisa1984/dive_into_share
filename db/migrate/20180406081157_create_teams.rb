class CreateTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|
      t.string :name, null: false
      t.text :discription
      t.string :image
      t.timestamps
    end
  end
end