require_relative 'statewide_test'
require 'pry'

class StatewideTestFormatter

  def yearly_data(category, row)
    binding.pry
    if category == 3 || 8
      binding.pry
      sub_hash = {category => {row[:timeframe] => {row[:score] => row[:data].to_f.round(3)}}}
    else
      binding.pry
      sub_hash = {row[:race_ethnicity] => {row[:timeframe] => {row[category] => row[:data].to_f.round(3)}}}
    end
  end

  def district_yearly_data(category, row)
    binding.pry
    statewide_test = StatewideTest.new({:name => row[:location]})
    append_district_yearly_data(statewide_test, category, row)
    statewide_test
  end

  def append_district_yearly_data(statewide_test, category, row)
    binding.pry
    merge_test_data(statewide_test, yearly_data(category, row), category, row)
  end

  def merge_test_data(statewide_test, yearly_data, category, row)
    binding.pry
    if statewide_test == 3 || 8
      binding.pry
      merge_test_by_grade(statewide_test, yearly_data, category, row[:timeframe])
    else
      binding.pry
      merge_test_by_race(statewide_test, yearly_data, category, row[:timeframe])
    end
  end

  def merge_test_by_race(object_info, row)
  #   binding.pry
  #   if object_info[:object].by_race.has_key?([object_info[:category]][row[:timeframe]])
  #     binding.pry
  #      object_info[:object].by_race[object_info[:category]][row][:timeframe]].merge!([row]:category]][object_info[:row][:timeframe]])
  #      binding.pry
  #   elsif object_info[:object].by_race.has_key?([object_info[:category]])
  #     binding.pry
  #      object_info[:object].by_race[object_info[:category]].merge!([object_info[:category]])
  #      binding.pry
  #   else
  #     binding.pry
  #     object_info[:object].by_race.merge!(object_info)
  #   end
  end

  def merge_test_by_grade(statewide_test, yearly_data, category, timeframe)
    binding.pry
    if statewide_test.by_grade.has_key?([category][timeframe])
      binding.pry
       statewide_test.by_grade[category][timeframe].merge!(yearly_data[category][timeframe])
       binding.pry
    elsif statewide_test.by_grade.has_key?([category])
      binding.pry
       statewide_test.by_grade[category].merge!(yearly_data[category])
    else
      binding.pry
      statewide_test.by_grade.merge!(yearly_data)
    end
  end
end
