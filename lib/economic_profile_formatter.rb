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
        if initial_row_rejection(row, category)
          if @economic_profiles_hash.empty?
            district_yearly_data(category, row)
          else
            unique_test?(category, row)
          end
        end
      end
    end
    binding.pry
  end

  def initial_row_rejection(row, category)
    row = nil if (category == :children_in_poverty && row[:dataformat] == "Number")
    (category == :free_or_reduced_price_lunch && row[:poverty_level] != "Eligible for Free or Reduced Lunch") ?
    nil : row
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
    @economic_profiles_hash << {:name => row[:location], category => yearly_data(category, row)}
  end

  def yearly_data(category, row)
    if category == :children_in_poverty ||  category == :title_i
      {row[:timeframe] => row[:data]}
    elsif category == :free_or_reduced_price_lunch
      free_or_reduced_price_lunch_format(row)
    elsif row[:timeframe].to_s.include?('-')
      {((row[:timeframe].split('-')).map{|i| i.to_i}) => row[:data]}
    end
      #{:median_household_income => {[2005, 2009] => 50000, [2008, 2014] => 60000}
  end

  def free_or_reduced_price_lunch_format(row)
    if row[:poverty_level] == ("Eligible for Free or Reduced Lunch") && (row[:dataformat] == "Percent")
      {row[:timeframe] => {:percentage => row[:data]}}
    elsif row[:poverty_level] == ("Eligible for Free or Reduced Lunch") && (row[:dataformat] == "Number")
      {row[:timeframe] => {:total => row[:data]}}
    end
  end

  def district_yearly_data(category, row)
    @economic_profiles_hash << {:name => row[:location], category => yearly_data(category, row)} if (yearly_data(category, row) != nil)
  end

  def merge_test_data(economic_profile, category, row)
    if economic_profile.has_key?(category)
      merge_sub_data(economic_profile, category, row)
    else
      economic_profile.merge!({category => yearly_data(category, row)})
    end
  end

  def merge_sub_data(economic_profile, category, row)
    if economic_profile[category].has_key?(row[:timeframe])
      economic_profile[category][row[:timeframe]].merge!(yearly_data(category, row)[row[:timeframe]])
    else
      economic_profile[category].merge!(yearly_data(category, row))
    end
  end
end