require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/economic_profile_repository'
require './lib/csv_parser'

class EconomicProfileTest < Minitest::Test

  def input

    ld = {
      :enrollment => {
              :kindergarten => "./data/Kindergartners in full-day program.csv"},
      :economic_profile => {
              :median_household_income => "./data/Median household income.csv",
              :children_in_poverty => "./data/School-aged children in poverty.csv",
              :free_or_reduced_price_lunch => "./data/Students qualifying for free or reduced price lunch.csv",
              :title_i => "./data/Title I students.csv"
  
                          }}
  end

  def test_estimated_median_income_in_year_returns_integer_for_2010
    ep = EconomicProfileRepository.new
    ep.load_data(input)
    assert_equal Integer, ep.economic_profiles[0].estimated_median_household_income_in_year(2010).class
  end  

  def test_estimated_median_income_in_year_returns_integer_for_2010
    ep = EconomicProfileRepository.new
    ep.load_data(input)
    assert_equal 57705, ep.economic_profiles[0].estimated_median_household_income_in_year(2010)
  end 

  def test_unknown_year_returns_unknown_data_error
    ep = EconomicProfileRepository.new
    ep.load_data(input)
    assert_raises "UnknownDataError" do
      ep.economic_profiles[0].estimated_median_household_income_in_year(3000)
    end
  end 

  def test_estimated_median_income_in_year_example_value
    ep = EconomicProfileRepository.new
    ep.load_data(input)
    assert (ep.economic_profiles[0].estimated_median_household_income_in_year(2010) >= 1)
  end 

  def test_median_household_income_average_returns_integer
    ep = EconomicProfileRepository.new
    ep.load_data(input)
    assert_equal Fixnum, ep.economic_profiles[0].median_household_income_average.class
  end 

  def test_median_household_income_average_example_value
    ep = EconomicProfileRepository.new
    ep.load_data(input)
    assert_equal 57408.0, ep.economic_profiles[0].median_household_income_average
  end 

  def test_children_in_poverty_for_invalid_year_raises_unknown_data
    ep = EconomicProfileRepository.new
    ep.load_data(input)
    assert_raises "UnknownDataError" do
      ep.economic_profiles[0].children_in_poverty_in_year(3000)
    end
  end 

  def test_children_in_poverty_for_year_example_value
    ep = EconomicProfileRepository.new
    ep.load_data(input)
    assert_equal 0.064, ep.economic_profiles[1].children_in_poverty_in_year(2012)
  end 

  def test_free_reduced_lunch_percentage_returns_float
    ep = EconomicProfileRepository.new
    ep.load_data(input)
    assert_equal Float, ep.economic_profiles[0].free_or_reduced_price_lunch_percentage_in_year(2011).class
  end 

  def test_free_reduced_lunch_percentage_raises_error_for_invalid_year
    ep = EconomicProfileRepository.new
    ep.load_data(input)
    assert_raises "UnknownDataError" do
      ep.economic_profiles[0].free_or_reduced_price_lunch_percentage_in_year(3000)
    end
  end 

  def test_free_reduced_lunch_percentage_returns_percentage_as_decimal
    ep = EconomicProfileRepository.new
    ep.load_data(input)
    assert (ep.economic_profiles[0].free_or_reduced_price_lunch_percentage_in_year(2013) <= 1) 
  end 

  def test_free_reduced_lunch_percentage_for_year_example_value
    ep = EconomicProfileRepository.new
    ep.load_data(input)
    assert_equal 0.125, ep.economic_profiles[1].free_or_reduced_price_lunch_percentage_in_year(2012)
  end 

  def test_free_reduced_lunch_number_return_integer
    ep = EconomicProfileRepository.new
    ep.load_data(input)
    assert_equal Fixnum, ep.economic_profiles[0].free_or_reduced_price_lunch_number_in_year(2011).class
  end 

  def test_free_reduced_lunch_number_raises_error_for_invalid_year
    ep = EconomicProfileRepository.new
    ep.load_data(input)
    assert_raises "UnknownDataError" do
      ep.economic_profiles[0].free_or_reduced_price_lunch_number_in_year(2220)
    end
  end 

  def test_free_or_reduced_price_lunch_number_in_year_is_positive
    ep = EconomicProfileRepository.new
    ep.load_data(input)
    assert (ep.economic_profiles[0].free_or_reduced_price_lunch_number_in_year(2010) >= 0)
  end 

  def test_free_or_reduced_price_lunch_number_in_year_example_value
    ep = EconomicProfileRepository.new
    ep.load_data(input)
    assert_equal 2601.0, ep.economic_profiles[1].free_or_reduced_price_lunch_number_in_year(2010)
  end 

  def test_title_one_in_year_returns_integer
    ep = EconomicProfileRepository.new
    ep.load_data(input)
    assert_equal Float, ep.economic_profiles[0].title_i_in_year(2011).class
  end 

  def test_title_one_in_year_returns_raises_error_for_invalid_year
    ep = EconomicProfileRepository.new
    ep.load_data(input)
    assert_raises "UnknownDataError" do
      ep.economic_profiles[0].title_i_in_year(2020)
    end
  end 

  def test_title_one_in_year_returns_percentage_as_decimal
    ep = EconomicProfileRepository.new
    ep.load_data(input)
    assert (ep.economic_profiles[0].title_i_in_year(2010) <= 1)
  end 

  def test_title_one_in_year_returns_integer
    ep = EconomicProfileRepository.new
    ep.load_data(input)
    assert_equal 0.011, ep.economic_profiles[1].title_i_in_year(2011)
  end 

  def test_title_one_in_year_is_positive
    ep = EconomicProfileRepository.new
    ep.load_data(input)
    refute (ep.economic_profiles[0].title_i_in_year(2010) <= 0)
  end 

end
