class Post
	attr_reader :db_client, :total_collection_size

	def initialize
		begin
			@db_client = MONGO_CLIENT.database
		rescue
			raise 'Mongo Client is down. Please check configuration.'
		end
	end

	def recent_rooms
		@db_client[:rooms].find({}, sort: {'post_time': -1}).first
	end

	def todays_rooms
		collection = @db_client[:rooms].find('post_time' => { '$gt' => Date.yesterday.strftime("%F") })
		@total_collection_size = collection.count_documents
		return collection
	end

end
