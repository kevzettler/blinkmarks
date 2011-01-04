if ENV['MONGOHQ_URL'] 
    #MongoMapper.config = {RAILS_ENV => {'uri' => ENV['MONGOHQ_URL']}}
    MongoMapper.connection = Mongo::Connection.new(ENV["MONGOHQ_URL"], nil) 
  else 
    #MongoMapper.config = {RAILS_ENV => {'uri' => 'mongodb://localhost/sushi'}}
    MongoMapper.connection = Mongo::Connection.new('localhost', 27017)
  end


#MongoMapper.connection = Mongo::Connection.new('localhost', 27017)

MongoMapper.database = "#bookmarks-#{Rails.env}"

if defined?(PhusionPassenger)
   PhusionPassenger.on_event(:starting_worker_process) do |forked|
     MongoMapper.connection.connect_to_master if forked
   end
end