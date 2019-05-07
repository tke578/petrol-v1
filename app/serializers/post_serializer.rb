class PostSerializer
  include FastJsonapi::ObjectSerializer
  attributes :post_time, :updated_post_time, :url, :title, :address, :price, :description, :post_status,
  			 :region, :state

  set_id { |object| object[:post_id] }
  attribute(:post_time) { |object| object[:post_time] }
  attribute(:updated_post_time) { |object| object[:updated_post_time] }
  attribute(:url) { |object| object[:url] }
  attribute(:title) { |object| object[:title]}
  attribute(:address) { |object| object[:address] }
  attribute(:price) { |object| object[:price] }
  attribute(:description) { |object| object[:description] }
  attribute(:post_status) { |object| object[:post_status] }
  attribute(:region) { |object| object[:region] }
  attribute(:state) { |object| object[:state] }

  
end
