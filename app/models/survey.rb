class Survey < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :user
  has_many   :answers, :through => :questions, dependent: :destroy 
  has_many   :questions

  validates :title, :presence => true
  

  def unique_url
    self.url = Digest::MD5.hexdigest("#{self.id}")
    self.save
  end
end
