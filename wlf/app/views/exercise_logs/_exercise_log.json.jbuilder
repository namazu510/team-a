json.extract! exercise_log, :id, :user_id, :start_time, :end_time, :step_cnt, :calorie, :schedule_id, :created_at, :updated_at
json.url exercise_log_url(exercise_log, format: :json)