class Answer < ActiveRecord::Base
  
  belongs_to :question
  has_many   :responses
  # Remember to create a migration!
end
