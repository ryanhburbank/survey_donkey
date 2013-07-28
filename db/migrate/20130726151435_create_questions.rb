class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.belongs_to :survey
      t.text       :text
      # t.string     :type, null: false

      t.timestamps
    end
  end
end
