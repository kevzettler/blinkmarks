if ENV['MONGOHQ_URL'] 
    MongoMapper.config = {RAILS_ENV => {'uri' => ENV['MONGOHQ_URL']}}
    #MongoMapper.database = "#bookmarks-#{Rails.env}"
  else 
    MongoMapper.config = {RAILS_ENV => {'uri' => 'mongodb://localhost/', 'port' => '27017'}}
    MongoMapper.database = "#bookmarks-#{Rails.env}"
  end

MongoMapper.connect(RAILS_ENV)


if defined?(PhusionPassenger)
   PhusionPassenger.on_event(:starting_worker_process) do |forked|
     MongoMapper.connection.connect_to_master if forked
   end
end