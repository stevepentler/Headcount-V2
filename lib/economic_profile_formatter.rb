require_relative 'statewide_test'
require 'pry'

class EconomicProfileFormatter

  attr_reader :economic_profile_formatter

  def initialize
    @economic_profiles_hash = []
  end

  def district_governor(statewide_testing_csv)
    statewide_testing_csv[:economic_profile].each do |category, test_rows|
      test_rows.each do |row|
        if @economic_profiles_hash.empty?
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
    @economic_profiles_hash.find {|state_test| state_test[:name] == row[:location]}
  end

  def district_yearly_data(category, row)
    @economic_profiles_hash << {:name => row[:location], sub_category_format(category, row) => yearly_data(category, row)}
  end

  def yearly_data(category, row)
    if category == :children_in_poverty || :title_i
      {row[:timeframe] => row[:data]}
    elsif category == :free_or_reduced_price_lunch
  end

  def free_or_reduced_price_lunch_format(row)
    if row[:poverty] == "Eligible for Free or Reduced Lunch" && row[:format] == "Percent"
    # {2014 => {:percentage => 0.023, :total => 100}}

  def district_yearly_data(category, row)
    @economic_profiles_hash << {:name => row[:location], category => yearly_data(category, row)}
  end

  def merge_test_data(economic_profile, category, row)
    if statewide_test.has_key?(category)
      if statewide_test[category].has_key?(row[:timeframe])
        statewide_test[category][row[:timeframe]].merge!(yearly_data(category, row)[row[:timeframe]])
      else
        statewide_test[category].merge!(yearly_data(category, row))
      end
    else
      statewide_test.merge!({category => yearly_data(category, row)})
    end
  end
end
