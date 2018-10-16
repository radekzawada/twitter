module Application
  class << self
    attr_accessor :config
  end

  self.config = OpenStruct.new
end

Application.config.twitter = OpenStruct.new(YAML.load_file('./config/twitter_api.yml'))
