require_relative 'statewide_test'
require 'pry'

class StatewideTestFormatter

  attr_reader :statewide_tests_hash

  def initialize
    @statewide_tests_hash = []
  end

  def district_governor(statewide_testing_csv)
    statewide_testing_csv[:statewide_testing].each do |category, test_rows|
      test_rows.each do |row|
        if @statewide_tests_hash.empty?
          district_yearly_data(category, row)
        else
          unique_test?(category, row)
        end
      end
    end
  end

  def unique_test?(category, row)
    if hash_find(row)
      merge_test_data(hash_find(row), category, row)
    else
      district_yearly_data(category, row)
    end
  end

  def hash_find(row)
    @statewide_tests_hash.find {|state_test| state_test[:name] == row[:location]}
  end

  def yearly_data(category, row)
    sub_category = sub_category_format(category, row)
    if sub_category.class == Fixnum
      sub_hash = {row[:timeframe] => {row[:score].downcase.to_sym => row[:data]}}
    else
      sub_hash = {row[:timeframe] => {category => row[:data]}}
    end
  end

  def sub_category_format(category, row)
    if category == :third_grade || category == :eighth_grade
      category = grade_format(category)
    else
      category = format_race(row)
    end
  end

  def grade_format(category)
    category = 3 if category == :third_grade
    category = 8 if category == :eighth_grade
    category
  end

  def format_race(row)
    if row[:race_ethnicity] == "Hawaiian/Pacific Islander"
      :hawaiian_pacific_islander
    else
      row[:race_ethnicity].downcase.split.join('_').to_sym
    end
  end

  def district_yearly_data(category, row)
    @statewide_tests_hash << {:name => row[:location], sub_category_format(category, row) => yearly_data(category, row)}
  end

  def merge_test_data(statewide_test, category, row)
    sub_category = sub_category_format(category, row)
    if statewide_test.has_key?(sub_category)
      if statewide_test[sub_category].has_key?(row[:timeframe])
        statewide_test[sub_category][row[:timeframe]].merge!(yearly_data(category, row)[row[:timeframe]])
      else
        statewide_test[sub_category].merge!(yearly_data(category, row))
      end
    else
      statewide_test.merge!({sub_category => yearly_data(category, row)})
    end
  end
end
