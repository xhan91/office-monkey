class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :critique, counter_cache: true
end