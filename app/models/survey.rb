class Survey < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :user
  has_many   :answers, :through => :questions
  has_many   :questions
end
