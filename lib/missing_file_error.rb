# frozen_string_literal: true

class MissingFileError < StandardError
  def initialize(msg = 'No such file or directory')
    super
  end
end
