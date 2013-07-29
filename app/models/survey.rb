class Survey < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :user
  has_many   :questions, dependent: :destroy 
  has_many   :answers, :through => :questions

  validates :title, :presence => true
  

  def unique_url
    self.url = Digest::MD5.hexdigest("#{self.id}").slice(0..11)
    self.save
  end
end
