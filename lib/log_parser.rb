# frozen_string_literal: true

require_relative 'missing_file_error'
require 'bundler'
require 'pry'

class LogParser
  def initialize(file_path)
    @file_path = file_path
    @page_views = page_views
  end

  def parse
    file_exist?(file_path)
    @page_views = Hash.new { |k, v| k[v] = [] }

    File.open(file_path).each do |line|
      page, ip = line.split
      @page_views[page] << ip
    end
    @page_views
  end

  attr_accessor :file_path, :page_views

  private

  def file_exist?(file_path)
    raise MissingFileError unless File.exist? file_path
  end
end
