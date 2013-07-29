class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.belongs_to :answer
      t.string     :email

      t.timestamps
    end
  end
end
