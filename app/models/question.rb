class Question < ActiveRecord::Base
  
  belongs_to :survey
  has_many   :answers, dependent: :destroy
  has_many   :responses, :through => :answers


  validates_uniqueness_of :text, :scope => :survey_id
  validates  :text, 
             :presence => {:on => :update } 

end

