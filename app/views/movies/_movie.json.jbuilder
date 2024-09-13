json.extract! movie, :id, :title, :cover_url, :summary, :year, :duration, :suggested_date, :user_id, :created_at, :updated_at
json.url movie_url(movie, format: :json)
