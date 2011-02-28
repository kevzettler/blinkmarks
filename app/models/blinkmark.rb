class Blinkmark
  include MongoMapper::Document
  plugin Hunt        
  
  key :url, String, :required => true
  key :title, String, :required => true
  key :tags, Array
  key :user_id, ObjectId
  timestamps!
  
  belongs_to :user
  
  searches :url, :title, :tags
  
  validates_presence_of :url, :title, :user_id
end