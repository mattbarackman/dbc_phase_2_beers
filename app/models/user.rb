class User < ActiveRecord::Base

  has_secure_password

  validates :name, :presence => true
  validates :email, :presence => true,
                    :uniqueness => true,
                    :format => {:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}
  
  validates :password, :presence => true,
                       :on => :create,
                       :length => {:minimum => 5, :maximum => 40}

  has_many :likes
  has_many :beers, through: :likes
  has_many :recommendations

end
