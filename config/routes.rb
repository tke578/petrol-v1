Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
  	namespace :v1 do
  	  defaults format: :json do
  	  	get 'rooms/recent_post', to: 'rooms#recent_post'
  	  	get 'rooms/todays_post', to: 'rooms#todays_post'
  	  end
  	end
  end
end
