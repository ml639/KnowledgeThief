class User < ActiveRecord::Base
  include Engage::Extensions::User
  has_many :searches, :class_name => 'UserSearch'
  has_many :resources
  has_many :comments
  has_many :resource_views, :class_name => 'UserResourceView'
  has_many :viewed_resources, :through => :resource_views, :source => :resource
  has_many :authentications
  has_many :evaluations, class_name: "RSEvaluation", as: :source

  has_reputation :votes, source: {reputation: :votes, of: :resources}, aggregated_by: :sum

  has_reputation :karma,
      :source => { :reputation => :votes, :of => :resources }

  def voted_for?(resource)
    evaluations.where(target_type: resource.class, target_id: resource.id).present?
  end

  def recently_viewed_resources
    viewed_resources.order('user_resource_views.created_at DESC')
  end


  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model

  attr_accessible :email, :password, :password_confirmation, :remember_me, :nickname, 
                  :first_name, :last_name, :image, :location, :birthday, :hometown_name, 
                  :bio, :gender, :full_name, :oauth_token

  # attr_accessible :title, :body

  def apply_omniauth(omniauth)
    self.email = omniauth['info']['email'] if email.blank?
    self.full_name = omniauth['info']['name'] if full_name.blank?
    self.nickname = omniauth['info']['nickname'] if nickname.blank?
    self.first_name = omniauth['info']['first_name'] if first_name.blank?
    self.last_name = omniauth['info']['last_name'] if last_name.blank?
    self.image = omniauth['info']['image'] if image.blank?
    self.location = omniauth['info']['location'] if location.blank?
    self.bio = omniauth['info']['description'] if bio.blank?
    self.birthday = omniauth['extra']['raw_info']['birthday'] if birthday.blank?
    #self.birthday = Date.strptime(self.birthday, '%m-%d-%Y') if birthday.blank?
    #raise omniauth['extra']['raw_info']['hometown']['name']
    self.gender = omniauth['extra']['raw_info']['gender'] if gender.blank?
    self.oauth_token = omniauth['credentials']['token'] if oauth_token.blank?
    self.hometown_name = omniauth['extra']['raw_info']['hometown']['name'] unless omniauth['extra']['raw_info']['hometown'].nil?

    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end

  
  def facebook
    @facebook ||= Koala::Facebook::API.new(oauth_token)
    block_given? ? yield(@facebook) : @facebook
  rescue Koala::Facebook::APIError => e
    logger.info e.to_s
    nil
  end
  
  def friends_count
    facebook { |fb| fb.get_connection("me", "friends").size }
  end

end
