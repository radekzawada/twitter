module Infrastructure
  module Queries
    module Params
      class DateValidator
        def valid?(date_string)
          !(date_string =~ /\A\d{4}-\d{2}-\d{2}\z/).nil?
        end

        def valid_order?(since_date, until_date)
          Date.parse(since_date) < Date.parse(until_date)
        end
      end
    end
  end
end
