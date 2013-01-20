# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


#user_email = "landontest@gmail.com"
#user_pass = "tester"

#user = User.create!(:email => user_email, 
 #                   :password = user_pass, 
 #                   :password_confirmation = user_pass)

# Confirm the user for Devise
# user.confirm!

require 'open-uri'
require 'active_record/fixtures'

#["Windows", "Linux", "Mac OS X"].each do |os|
 # OperatingSystem.find_or_create_by_name(os)
#end

Resource.delete_all # Have this line if we want to delete all resources before we add them.
open("http://atr.eng.utah.edu/~lwilkins/kt/seed_resources.txt") do |seed_resources|
  seed_resources.read.each_line do |r|
    title, media_type, link, description, tags = r.chomp.split("|")
    temp_resource = Resource.create!(:title => title, 
    								 :link => link, 
    								 :description => description,
    								 :media_type => media_type)
    temp_resource.tag_list = tags
    temp_resource.save!
  end
end

#Fixtures.create_fixtures("#{Rails.root}/test/fixtures", "operating_systems")
