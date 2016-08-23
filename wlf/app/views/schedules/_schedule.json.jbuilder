json.extract! schedule, :id, :user_id, :start_time, :end_time, :comment, :created_at, :updated_at
json.url schedule_url(schedule, format: :json)