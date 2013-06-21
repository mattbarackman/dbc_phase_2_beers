class Beer < ActiveRecord::Base
  
  validates_presence_of :name

  has_many :likes
  has_many :users, through: :likes
  

end
