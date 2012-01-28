class User < ActiveRecord::Base
  # new columns need to be added here to be writable through mass assignment
  attr_accessible :username, :email, :password, :password_confirmation, :group_id, :is_client, :is_gym, :is_trainer, :coach, 
    :client_training_id, :first_name, :last_name, :logo_image, :remote_logo_image_url, :gym_attributes

  mount_uploader :logo_image, ImageUploader

  has_one :gym, :dependent => :destroy
  has_one :trainer, :dependent => :destroy
  has_one :client, :dependent => :destroy

  has_many :workouts
  has_many :workout_sessions
  has_many :exercises
#  has_many :clients
  belongs_to :group
  has_many :bodycomps, :through => :clients
  has_one :subscription

  accepts_nested_attributes_for :gym, :allow_destroy => true,
#    :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }
    :reject_if => proc { |attributes| attributes['name'].blank? }

  attr_accessor :password
  before_save :prepare_password
  
  validates_presence_of :username
  validates_uniqueness_of :username, :email, :allow_blank => true
  validates_format_of :username, :with => /^[-\w\._@]+$/i, :allow_blank => true, :message => "should only contain letters, numbers, or .-_@"
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates_presence_of :password, :on => :create
  validates_confirmation_of :password
  validates_length_of :password, :minimum => 4, :allow_blank => true
  
  # login can be either username or email address
  def self.authenticate(login, pass)
    user = find_by_username(login) || find_by_email(login)
    return user if user && user.matching_password?(pass)
  end
  
  def matching_password?(pass)
    self.password_hash == encrypt_password(pass)
  end

  def full_name
    if !first_name.blank? || !last_name.blank?
      "#{first_name} #{last_name}".strip
    else
      id
    end
  end
  
  private
  
  def prepare_password
    unless password.blank?
      self.password_salt = Digest::SHA1.hexdigest([Time.now, rand].join)
      self.password_hash = encrypt_password(password)
    end
  end
  
  def encrypt_password(pass)
    Digest::SHA1.hexdigest([pass, password_salt].join)
  end
end
