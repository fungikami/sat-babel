require "time"
require "icalendar"

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
  -> (i, j, k, l) {
    n_available_hours * (n_days * (n_participants * i + j) + k) + l + 1
  }
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
            map_to_cnf.(i, j, k, l),
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

# Measure the time it takes to execute a block
#
# @param block [Block] the block to measure
# @return [Float] the time it took to execute the block
def measure_time(&block)
  start = Time.now
  block.call
  Time.now - start
end

# Check if a tournament is plausible given its parameters
#
# @param n_participants [Integer] the number of participants
# @param n_days [Integer] the number of days
# @param n_hours [Integer] the number of hours
# @return [Boolean] true if the problem at least makes sense, false otherwise
def makes_sense?(n_participants, n_days, n_hours)
  (n_participants > 1 &&
   n_days > 1 &&
   n_hours > 1 &&
   n_days >= 2 * (n_participants - 1) &&
   n_hours * n_days >= 2 * n_participants * (n_participants - 1))
end

# Extract solution from a solution file
#
# @param solution_filename [String] the name of the solution file
# @param n_participants [Integer] the number of participants
# @param n_days [Integer] the number of days
# @param n_hours [Integer] the number of hours
# @return [Array] the solution
def extract_solution(solution_filename, n_participants, n_days, n_hours)
  File.open(solution_filename, "r") do |f|
    solution_string = f.readline.strip

    if solution_string == "UNSAT"
      return []
    end

    solution_string.split(" ")
      .map(&:to_i)
      .select { |x| x > 0 }
      .map { |x| map_from_cnf(x, n_participants, n_days, n_hours - 1) }
  end
end

# Create .ics file from solution
#
# @param solution [Array] the solution
# @param tournament_name [String] the name of the tournament
# @param participants [Array] the participants
# @param start_date [String] the start date
# @param start_time [String] the start time
# @return [String] the .ics filename
def create_ics(solution, tournament_name, participants, start_date, start_time)
  # Parse start date and time
  start_date = Date.parse(start_date)
  start_time = Time.parse(start_time)

  # Round time if min > 0, add to start date to get the next o'clock
  if start_time.min > 0 || start_time.sec > 0
    start_time = Time.parse("#{start_time.hour + 1}:00:00")
  end

  # Create a new time object with the rounded time

  # Create the calendar
  cal = Icalendar::Calendar.new

  for game in solution
    # Create the event
    cal.event do |e|
      player1, player2, day, hour = game
      game_date = start_date + day
      game_hour = start_time.hour + hour

      e.dtstart = DateTime.new(
        game_date.year,
        game_date.month,
        game_date.day,
        game_hour
      )

      e.dtend = DateTime.new(
        game_date.year,
        game_date.month,
        game_date.day,
        game_hour + 2
      )

      e.summary = "#{tournament_name}: #{participants[player1]} vs #{participants[player2]}"
      e.description = <<~DESCRIPTION
                                    On #{game_date.strftime("%A, %B %d, %Y")}, from #{game_hour}:00 to #{game_hour + 2}:00,
      #{participants[player1]} will play against #{participants[player2]}.

      - #{participants[player1]} play as local
      - #{participants[player2]} play as visitor

      May the best win!
      DESCRIPTION
    end
  end

  filename = "#{tournament_name}.ics"
  File.open(filename, "w") do |f|
    f.write(cal.to_ical)
  end

  filename
end
