# frozen_string_literal: true

module SortResults
  extend self

  def sort_unique
    @sort_unique ||= views_size(unique: true).sort_by { |_k, v| -v }.to_h
  end

  def sort_all
    @sort_all ||= views_size(unique: false).sort_by { |_k, v| -v }.to_h
  end

  private

  def views_size(unique:)
    views_hash.transform_values do |v|
      unique ? v.uniq.size : v.size
    end
  end
end
