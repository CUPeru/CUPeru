if ENV['REDIS_URL']
  uri = URI.parse(ENV['REDIS_URL'])
  Resque.redis = Redis.new(host: uri.host,
                           port: uri.port,
                           password: uri.password)
else
  Resque.redis = Redis.new
end

Resque.schedule = YAML.load_file('config/schedule.yml')
