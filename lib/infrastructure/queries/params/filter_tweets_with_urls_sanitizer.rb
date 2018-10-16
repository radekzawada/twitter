module Infrastructure
  module Queries
    module Params
      class FilterTweetsWithUrlsSanitizer
        def initialize(default_filters, user_name)
          @default_filters = default_filters
          @user_name = user_name
        end

        def sanitize!(params)
          raise ::Exceptions::WrongParameterException, 'USER_NAME parameter is not set' unless user_name

          default_filters.each do |key, values|
            sanitize_default!(params, key, values)
          end
          sanitize_default!(params, :from, user_name)
        end

        private

        attr_reader :default_filters, :user_name

        def sanitize_default!(params, key, default)
          params[key] ||= []
          params[key] += [default].flatten
          params[key].uniq!
        end
      end
    end
  end
end
