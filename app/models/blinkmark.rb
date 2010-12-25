class Blinkmark
  include MongoMapper::Document         
  
  key :url, String
  key :title, String
  key :tags, Array
  timestamps!
end