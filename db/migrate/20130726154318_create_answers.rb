class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.belongs_to :question
      t.text       :answer
      
      t.timestamps
    end
  end
end
