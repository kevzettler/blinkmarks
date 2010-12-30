class Blinkmark
  include MongoMapper::Document
  plugin Hunt        
  
  key :url, String, :required => true
  key :title, String, :required => true
  key :tags, Array
  
  searches :url, :title, :tags
end