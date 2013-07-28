class Response < ActiveRecord::Base
  
  belongs_to :answer
  validates :email, :presence => true
  validates_uniqueness_of :answer_id, :scope => :email 

end
