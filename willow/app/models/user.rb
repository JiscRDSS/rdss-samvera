class User < ApplicationRecord
  # Connects this user object to Hydra behaviors.
  include Hydra::User
  # Connects this user object to Role-management behaviors.
  include Hydra::RoleManagement::UserRoles

  # Connects this user object to Hyrax behaviors.
  include Hyrax::User
  include Hyrax::UserUsageStats

  if Blacklight::Utils.needs_attr_accessible?
    attr_accessible :email, :password, :password_confirmation
  end
  # Connects this user object to Blacklights Bookmarks.
  include Blacklight::User

  validates :uid, presence: true, uniqueness: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :remote_user_authenticatable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:shibboleth]

  # Method added by Blacklight; Blacklight uses #to_s on your
  # user class to get a user-displayable login/identifier for
  # the account.
  def to_s
    email
  end

  def user_key
    uid || super
  end

  # @param auth [OmniAuth::AuthHash] authenticated user information.
  # @return [User] the authenticated user, possibly a newly created record.
  def self.from_omniauth(auth)
    find_or_initialize_by(uid: auth.uid).tap do |user|
      user.password = Devise.friendly_token if user.new_record?
      user.update!(email: auth.info.email, display_name: auth.info.name)
    end
  end
end
