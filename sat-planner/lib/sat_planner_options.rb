require 'optparse'

module SatBabelOptions
  def parse(args)
    options = {}

    # Parse options
    OptionParser.new do |opts|
      opts.banner = "Usage: sat-babel [options]"

      opts.on("-h", "--help", "Prints this help") do
        puts opts
        exit
      end

      opts.on("-f", "--file FILE", "Specify input file") do |file|
        options[:file] = file
      end
    end.parse!(args)
  end

  module_function :parse
end
