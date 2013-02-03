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

File.open("app/assets/files/seed_resources.txt") do |seed_resources|
  seed_resources.each_line do |r|
    pairs = r.chomp.split("|")
    title = pairs[0].unpack("C*").pack("U*")
    media_type = pairs[1].unpack("C*").pack("U*")
    link = pairs[2].unpack("C*").pack("U*")
    description = pairs[3].unpack("C*").pack("U*")
    tags = pairs[4].unpack("C*").pack("U*")

    temp_resource = Resource.create!(:title => title,
                     :link => link,
                     :description => description,
                     :media_type => media_type)
    temp_resource.tag_list = tags

    url = PostRank::URI.clean(temp_resource.link)

    side_size = 300
    crop_side_size = 300

    kit = IMGKit.new(url, :quality => 50,
                          :width   => side_size,
                          :height  => side_size,
                          "crop-w" => crop_side_size,
                          "crop-h" => crop_side_size,
                          "zoom"   => 0.35,
                          "disable-smart-width" => true,
                          "load-error-handling" => "ignore")

    img   = kit.to_img(:jpg)

    file  = Tempfile.new(["resource_#{temp_resource.id}", 'jpg'], 'tmp',
                         :encoding => 'ascii-8bit')
    file.write(img)
    file.flush
    temp_resource.snapshot = file
    temp_resource.save!
    file.unlink
  end
end

#Fixtures.create_fixtures("#{Rails.root}/test/fixtures", "operating_systems")
