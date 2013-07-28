class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.belongs_to :user
      t.string     :title, null: false
      t.string     :url
      t.text       :overview
      
      t.timestamps
    end
  end
end
