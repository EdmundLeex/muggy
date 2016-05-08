uri = URI.parse(ENV["redis_url"])
redis = Redis.new(:url => uri)