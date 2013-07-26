class Questions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :text
      t.belongs_to : 
  end
end
