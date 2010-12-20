class User
  include MongoMapper::Document         
  plugin MongoMapper::Devise
  devise :registerable, :database_authenticatable, :recoverable, :trackable 
  
  key :email, String
  key :bookmark_ids, Array
  
  timestamps!
end