uri = URI.parse(ENV["redis_url"])
Redis ||= Redis.new(:url => uri)