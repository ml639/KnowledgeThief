# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


user_email = "landontest@gmail.com"
user_pass = "tester"

user = User.create!(:email => user_email, 
                    :password = user_pass, 
                    :password_confirmation = user_pass)

# Confirm the user for Devise
user.confirm!

resource_title = "Harvard Computer Systems and Machine Organization Lectures"
resource_description = "bla bla"
resource_link = "http://google.com"
resource_tag_list = "computer systems, machine organization, computer science"

r = Resource.create!(:title => resource_title, 
                     :description = resource_description, 
                     :link = resource_link)

r.tag_list = tag_string

r.save!
