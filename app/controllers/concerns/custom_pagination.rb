module CustomPagination
	extend ActiveSupport::Concern

	included do
      before_action :default_params, only: [:todays_post]
    end

    def default_params
    	@default_offset = 30
    	@current_page = 1
    end

    def update_default_params
		if params[:page].present? && params[:page][:offset].present?
            # if params[:page][:offset].to_i < 0
            #     redirect_to root_path and return 
            #     # return
            # end
			@current_page = params[:page][:offset].to_i
			@default_offset = @default_offset * params[:page][:offset].to_i
		end
    end

    def build_pagination(collection, total_collection_size, resource_path)
    	
    	query_string = '?page[offset]='

    	next_link, prev_link = nil, nil
        first_link, last_link = nil, nil
    	if @default_offset < total_collection_size
    		#get remainder
    		if @default_offset + 30 < total_collection_size
	    		next_link = resource_path + query_string + (@current_page+1).to_s
	    		prev_link = resource_path + query_string + (@current_page-1).to_s
	    	else
	    		next_link = nil
	    		prev_link = resource_path + query_string + (@current_page-1).to_s
	    		@default_offset = total_collection_size
	    	end
        end

        if  total_collection_size > 0
            first_link = resource_path + query_string + '1'
            last_link = resource_path + query_string + ((total_collection_size/@default_offset).ceil).to_s
        end

    	options = {}
    	options[:links] = {
    		next: next_link, prev: prev_link, first: first_link, last: last_link,
    		total_count: total_collection_size, current_count: @default_offset.to_s + " out of #{total_collection_size.to_s}" 
    	}

    	@links = options


    end


    

end