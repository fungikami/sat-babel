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

# Creates a map from the initial space:
#   n_participants x n_participants x n_days x n_available_hours
# to the CNF space:
#   Flattened to a single dimension and 1-indexed
#
# @param n_participants [Integer] the number of participants
# @param n_days [Integer] the number of days
# @param n_available_hours [Integer] the number of available hours
# @return [Array] the map
def create_map_to_cnf(n_participants, n_days, n_available_hours)
  n = 1
  map = []

  for i in 0...n_participants
    map[i] = []
    for j in 0...n_participants
      map[i][j] = []
      for k in 0...n_days
        map[i][j][k] = []
        for l in 0...n_available_hours
          map[i][j][k][l] = n
          n += 1
        end
      end
    end
  end

  map
end

# Maps from CNF space to the initial space back to the initial space
# (see create_map_to_cnf)
#
# @param n [Integer] the number to map from CNF space
# @param n_participants [Integer] the number of participants
# @param n_days [Integer] the number of days
# @param n_available_hours [Integer] the number of available hours
# @return [Array] the mapped number
def map_from_cnf(n, n_participants, n_days, n_available_hours)
  # Translate to 0-indexed by subtracting 1 (from DIMACS)
  n -= 1

  # Get the indices
  l = n % n_available_hours

  n /= n_available_hours
  k = n % n_days

  n /= n_days
  j = n % n_participants

  n /= n_participants
  i = n

  return i, j, k, l
end

# Test map from CNF space to the initial space and inverse
#
# @param n_participants [Integer] the number of participants
# @param n_days [Integer] the number of days
# @param n_available_hours [Integer] the number of available hours
# @return [Boolean] true if the test passed, false otherwise
def test_maps(n_participants, n_days, n_available_hours)

  # Create the map
  map_to_cnf = create_map_to_cnf(n_participants, n_days, n_available_hours)

  for i in 0...n_participants
    for j in 0...n_participants
      for k in 0...n_days
        for l in 0...n_available_hours
          # Verify that f^-1(f(v)) == v
          if [i, j, k, l] != map_from_cnf(
            map_to_cnf[i][j][k][l],
            n_participants,
            n_days,
            n_available_hours
          )
            return false
          end
        end
      end
    end
  end

  true
end