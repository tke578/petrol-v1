class Api::V1::RoomsController < Api::V1::BaseController
	include CustomPagination
	before_action :init_client

	def recent_post
		room = Rails.cache.fetch("#{Date.today}/recent_rooms_post", expires_in: 1.hours) do 
			@db.recent_rooms
		end
		render json: PostSerializer.new(room)
	end

	def todays_post
		update_default_params if params[:page].present?

		rooms_collection = []
		
		redirect_to root_path and return if @default_offset < 0 #there must be a better way
		@db.todays_rooms.skip(@default_offset).limit(30).each { |rm| rooms_collection << rm }
		build_pagination(rooms_collection, @db.total_collection_size, api_v1_rooms_todays_post_path)

		render json: PostSerializer.new(rooms_collection, @links)
	end

	private

	def init_client
		@db = Post.new
	end

end