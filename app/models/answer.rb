  
  # Remember to create a migration!
  belongs_to :question
  has_many   :responses
class Answer < ActiveRecord::Base
end
