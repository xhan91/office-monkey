class Critique < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject
  has_many :votes

end