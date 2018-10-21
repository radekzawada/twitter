module Infrastructure
  module Queries
    module Params
      class TweetsWithUrlsSanitizer
        def initialize(default_filters, user_name, dependencies)
          @default_filters = default_filters
          @user_name = user_name
          @date_validator = dependencies.fetch(:date_validator)
        end

        def sanitize!(params)
          raise ::Exceptions::NilParameterException, 'TWITTER_USER_NAME system variable is not set' unless user_name

          default_filters.each do |key, values|
            sanitize_default!(params, key, values)
          end

          sanitize_default!(params, :from, user_name)
          validate_dates(params)

          params.reject! { |k, v| v.nil? || !attributes.include?(k) }
        end

        private

        attr_reader :default_filters, :user_name, :date_validator

        def validate_dates(params)
          validate_date(params[:since]) if params[:since]
          validate_date(params[:until]) if params[:until]
          validate_order(*params.values_at(:since, :until)) if params[:since] && params[:until]
        end

        def validate_order(since_date, until_date)
          valid = date_validator.valid_order?(since_date, until_date)
          raise_exception('until_date cannot be before since_date') unless valid
        end

        def sanitize_default!(params, key, default)
          params[key] ||= []
          params[key].concat [default].flatten
          params[key].uniq!
        end

        def validate_date(date_string)
          raise_exception('wrong date format, should be YYYY-MM-DD') unless date_validator.valid?(date_string)
        end

        def attributes
          %i[from filter -filter since until]
        end

        def raise_exception(error_msg)
          raise Exceptions::WrongParameterException, error_msg
        end
      end
    end
  end
end
