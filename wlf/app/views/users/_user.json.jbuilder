json.extract! user, :id, :name, :email, :admin, :password, :gender, :height, :age, :created_at, :updated_at
json.url user_url(user, format: :json)