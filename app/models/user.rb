class User
  include MongoMapper::Document         
  plugin MongoMapper::Devise
  devise :registerable, :database_authenticatable, :recoverable, :trackable, :rememberable 
  
  # Attributes ::::::::::::::::::::::::::::::::::::::::::::::::::::::
  key :email, String, :required => true
  key :password, String, :required => true
  timestamps!
  
  # Validations :::::::::::::::::::::::::::::::::::::::::::::::::::::
  RegEmailName   = '[\w\.%\+\-]+'
  RegDomainHead  = '(?:[A-Z0-9\-]+\.)+'
  RegDomainTLD   = '(?:[A-Z]{2}|com|org|net|gov|mil|biz|info|mobi|name|aero|jobs|museum)'
  RegEmailOk     = /\A#{RegEmailName}@#{RegDomainHead}#{RegDomainTLD}\z/i
  
  validates_presence_of :email, :password
  validates_length_of :email, :within => 6..100
  validates_format_of :email, :with => RegEmailOk
  validates_uniqueness_of :email
  validates_confirmation_of :password
  
  # Associations ::::::::::::::::::::::::::::::::::::::::::::::::::::
  many :blinkmarks
end