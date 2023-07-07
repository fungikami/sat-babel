require 'time'

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


def f(i, j, k, l)
  # Para probar owo
  n_participants = 30
  n_days = 30
  n_hours = 24

  # Translate to 1-indexed by adding 1 (for DIMACS)
  (n_hours - 1) * (n_days * (n_participants * i + j) + k) + l + 1
end

def f_inverse(n)
  # Para probar awa
  n_participants = 30
  n_days = 30
  n_hours = 24

  # Translate to 0-indexed by subtracting 1 (from DIMACS)
  n -= 1
  l = n % (n_hours - 1)
 
  n /= (n_hours - 1)
  k = n % n_days

  n /= n_days
  j = n % n_participants

  n /= n_participants
  i = n

  return i, j, k, l
end

def test_f
  n_participants = 30
  n_days = 30
  n_hours = 24

  for i in 0...n_participants
    for j in 0...n_participants
      for k in 0...n_days
        for l in 0...(n_hours - 1)
          # Verify that f_inverse(f(i, j, k, l)) == (i, j, k, l)
          if  [i, j, k, l] != f_inverse(f(i, j, k, l))
            return false
          end
        end
      end
    end
  end

  true
end