class User < ActiveRecord::Base
  has_many :critiques
  has_many :votes
end