require 'mongo'

MONGO_CLIENT = Mongo::Client.new('mongodb://'+ENV['MONGO_USER']+':'+ENV['MONGO_PW']+'@'+ENV['MONGO_URI']+':'+ENV['MONGO_PORT']+'/'+ENV['MONGO_DB'])