require 'json'

# Read a JSON file and return the JSON object
#
# @param filename [String] the name of the file to read
# @return [Hash] the JSON object
def read_json_file(filename)
    file = File.read(filename)
    JSON.parse(file)
end

# Write a JSON object to a file
#
# @param json [Hash] the JSON object to write
def print_json(json)
    puts JSON.pretty_generate(json)
end
