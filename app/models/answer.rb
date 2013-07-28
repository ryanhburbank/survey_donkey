class Answer < ActiveRecord::Base
  belongs_to :question
  has_many   :responses

  validates :text, 
            :uniqueness => true, 
            :presence => { :on => :update }

  validates_uniqueness_of :text, 
                          :scope => :question_id
end
