class User < ActiveRecord::Base
  include Engage::Extensions::User
  has_many :resources
  has_many :comments
  has_many :resource_views, :class_name => 'UserResourceView'
  has_many :viewed_resources, :through => :resource_views, :source => :resource
  
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
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
end
