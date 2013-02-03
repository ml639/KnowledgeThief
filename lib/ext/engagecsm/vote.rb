require 'engagecms'
#make this the correct require for the gem, the goal is to force the gem to load before your code

class Engage::Vote < ActiveRecord::Base # you'll need to make this declaration equal the engage one
  attr_accessible :user
end
