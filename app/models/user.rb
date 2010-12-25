class User
  include MongoMapper::Document         
  plugin MongoMapper::Devise
  devise :registerable, :database_authenticatable, :recoverable, :trackable, :remeberable 
  
  key :email, String
  key :bookmark_ids, Array
  key :tags, Array
  
  timestamps!
end