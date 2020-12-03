# frozen_string_literal: true

require_relative 'log_parser'
require_relative 'sort_results'

class PrintResults
  include SortResults

  def initialize(parser)
    @parser = parser
    @views_hash = parser.page_views
  end

  def call
    puts "\n"
    puts 'LIST OF MOST PAGE VIEWS'
    print_results(sort_all)
    puts "\n\n"
    puts 'LIST OF MOST UNIQUE PAGE VIEWS'
    print_results(sort_unique)
  end

  attr_accessor :views_hash

  private

  def print_results(sorted_hash)
    puts "\n"
    puts "#{'PAGE'.center(20)} | VIEWS"
    puts '---------------------+----------'
    sorted_hash.each do |page, views_no|
      puts "#{page.ljust(20)} | #{views_no}"
    end
  end
end
