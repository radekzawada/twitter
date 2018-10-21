module Infrastructure
  module Queries
    module Builders
      class TweetsWithUrls
        def initialize(dependencies)
          @params_sanitizer = dependencies.fetch(:params_sanitizer)
          @connectors = dependencies.fetch(:connectors)
        end

        def build_filter_with_urls_query(params, user_names)
          params_sanitizer.sanitize! params
          insert_from_params! params, user_names

          connect_params params
        end

        private

        attr_accessor :params_sanitizer, :connectors

        def connect_params(params)
          params.map do |key, values|
            connect_values(key, values)
          end.join(' ')
        end

        def connect_values(key, values)
          connector = connectors[key] || ' '
          [values].flatten.map { |v| "#{key}:#{v}" }.join(" #{connector} ")
        end

        def insert_from_params!(params, user_names)
          params[:from] += user_names
          params[:from].uniq!
        end
      end
    end
  end
end
