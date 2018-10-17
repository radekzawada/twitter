module Infrastructure
  module Queries
    module Params
      class TweetsWithUrlsSanitizer
        def initialize(default_filters, user_name)
          @default_filters = default_filters
          @user_name = user_name
        end

        def sanitize!(params)
          raise ::Exceptions::WrongParameterException, 'TWITTER_USER_NAME system variable is not set' unless user_name

          default_filters.each do |key, values|
            sanitize_default!(params, key, values)
          end
          sanitize_default!(params, :from, user_name)
        end

        private

        attr_reader :default_filters, :user_name

        def sanitize_default!(params, key, default)
          params[key] ||= []
          params[key].concat [default].flatten
          params[key].uniq!
        end
      end
    end
  end
end
