json.extract! post, :id, :title, :content, :stop_id, :created_at, :updated_at
json.url post_url(post, format: :json)
