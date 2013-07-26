class AddSentColumnToSurveys < ActiveRecord::Migration
  def change
    add_column :surveys, :sent, :integer, default: 0
  end
end
