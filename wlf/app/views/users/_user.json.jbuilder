json.extract! user, :id, :name, :email, :socialId, :admin, :password, :access_token, :access_token_secret, :gender, :height, :age, :created_at, :updated_at
json.url user_url(user, format: :json)