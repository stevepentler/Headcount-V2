require_relative 'statewide_test'
require 'pry'

class StatewideTestFormatter

  def yearly_data(category, row)
    if category.class == Fixnum
      category = category_reformat(category)
      sub_hash = {category => {row[:timeframe].to_i => {row[:score] => row[:data].to_f.round(3)}}}
    else
      sub_hash = {row[:race_ethnicity] => {row[:timeframe] => {category => row[:data].to_f.round(3)}}}
    end
  end

  def category_reformat(category)
    if category == :third_grade
      category = 3
    elsif category == :eigth_grade
      category = 8
    end
  end

  def district_yearly_data(category, row)
    statewide_test = StatewideTest.new({:name => row[:location]})
    append_district_yearly_data(statewide_test, category, row)
    statewide_test
  end

  def append_district_yearly_data(statewide_test, category, row)
    merge_test_data(statewide_test, yearly_data(category, row), category, row)
  end

  def merge_test_data(statewide_test, yearly_data, category, row)
    if category.class == Fixnum
      merge_test_by_grade(statewide_test, yearly_data, category, row[:timeframe].to_i)
    else
      merge_test_by_race(statewide_test, yearly_data, category, row[:timeframe], row[:race_ethnicity])
    end
  end

  def merge_test_by_race(statewide_test, yearly_data, category, timeframe, race_ethnicity)
    if statewide_test.by_race.has_key?(race_ethnicity)
      if statewide_test.by_race[race_ethnicity].has_key?(timeframe)
        statewide_test.by_race[race_ethnicity][timeframe].merge!(yearly_data[race_ethnicity][timeframe])
      else
        statewide_test.by_race[race_ethnicity].merge!(yearly_data[race_ethnicity])
      end
    else
      statewide_test.by_race.merge!(yearly_data)
    end
  end

  def merge_test_by_grade(statewide_test, yearly_data, category, timeframe)
    if statewide_test.by_grade.has_key?(category)
      if statewide_test.by_grade[category].has_key?(timeframe)
        statewide_test.by_grade[category][timeframe].merge!(yearly_data[category][timeframe])
      else
        statewide_test.by_grade[category].merge!(yearly_data[category])
      end
    else
      statewide_test.by_grade.merge!(yearly_data)
    end
  end
end
