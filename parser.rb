# frozen_string_literal: true

require_relative 'lib/print_results'

parser = LogParser.new(ARGV[0])
parser.parse
PrintResults.new(parser).call
