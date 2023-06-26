require 'time'

# Get the number of hours between two times
#
# @param start_time [String] the first time
# @param end_time [String] the second time
# @return [Integer] the number of hours between the two times
def get_hours(start_time, end_time)
    start_time = Time.parse(start_time)
    end_time = Time.parse(end_time)

    n_hours = end_time.hour - start_time.hour

    # If minute is not exactly on the hour, "round up"
    if start_time.min > 0
        n_hours -= 1
    end

    n_hours
end

# Get the number of days between two dates
#
# @param start_date [String] the first date
# @param end_date [String] the second date
# @return [Integer] the number of days between the two dates
def get_days(start_date, end_date)
    start_date = Date.parse(start_date)
    end_date = Date.parse(end_date)

    (end_date - start_date).to_i + 1
end
