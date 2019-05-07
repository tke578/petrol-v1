class Api::V1::RoomsController < Api::V1::BaseController
	require 'will_paginate/array'
	before_action :init_client

	def recent_post
		room = Rails.cache.fetch("#{Date.today}/recent_rooms_post", expires_in: 1.hours) do 
			@db.recent_rooms
		end
		render json: PostSerializer.new(room)
	end

	def todays_post
		default_offset = 30
		current_page = 1
		
		if params[:page].present? && params[:page][:offset].present?
			current_page = params[:page][:offset].to_i
			default_offset = default_offset * params[:page][:offset].to_i

		end
		# if params[:page][:offset].present?

		# 	if params[:page][:offset].
		# 	next_current_offset = 
		# end
		rooms = []
		collection = @db.todays_rooms.skip(default_offset).limit(30).each { |rm| rooms << rm }
		last_page = (@db.total_collection_size/30).ceil
		options = {}
		options[:links] = {
		  next: api_v1_rooms_todays_post_path + "?page[offset]=#{current_page+1}",
		  prev: api_v1_rooms_todays_post_path + "?page[offset]=#{current_page-1}",
		  first: api_v1_rooms_todays_post_path + "?page[offset]=1",
		  last: api_v1_rooms_todays_post_path + "?page[offset]=#{last_page}",
		  total_count: @db.total_collection_size,
		  current_count: default_offset.to_s + " out of #{@db.total_collection_size.to_s}" 

		}
		render json: PostSerializer.new(rooms, options)
		# paginate json: PostSerializer.new(rooms, options), per_page: 10
	end

	private

	def init_client
		@db = Post.new
	end

end