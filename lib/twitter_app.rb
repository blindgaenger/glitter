class TwitterConfig < OpenStruct
  def initialize(config_file)
    @config_file = File.expand_path(config_file)
    filename = File.exist?(@config_file) ? @config_file : 'default.yml'
    super(YAML.load(File.read(filename)))
  end
  
  def store
    unless File.exist? @config_file
      File.makedirs File.dirname(@config_file)
    end
    File.open(@config_file, 'w') do |file|
      file.puts YAML.dump(marshal_dump)
    end
  end
end

class TwitterApp < Twitter::Base

  def self.authorize(config, &block)
    consumer = OAuth::Consumer.new(config.ctoken, config.csecret, { :site=>config.csite })
    request_token = consumer.get_request_token

    counter = 0
    loop do
      # ask the user to open the url in its browser and allow access
      begin
        oauth_verifier = yield request_token.authorize_url, counter
      rescue Exception => ex
        return false # something went wrong or the callback wants to exit
      end
      counter += 1

      # now that the request_token is authorized we can get an access token
      begin
        access_token = request_token.get_access_token(:oauth_verifier => oauth_verifier)
        config.atoken = access_token.token
        config.asecret = access_token.secret
        config.store
        return true # user authorized and it works
      rescue OAuth::Unauthorized => ex
        # ignore and try again
      end
    end
  end

  def initialize(config)
    oauth = Twitter::OAuth.new(config.ctoken, config.csecret)
    oauth.authorize_from_access(config.atoken, config.asecret)
    super(oauth)
  end

  def last_status(user_id)
    statuses = self.user_timeline({:id => user_id, :count => 1})
    statuses.first
  end

  def reply(status, message)
    self.update("@#{status.user.screen_name} #{message}", {:in_reply_to_status_id => status.id})
  end
end

