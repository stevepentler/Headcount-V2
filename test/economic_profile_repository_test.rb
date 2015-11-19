require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/economic_profile_repository'
require './lib/csv_parser'
require './lib/district_repository'

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

  def test_repo_stores_object_name
    er = EconomicProfileRepository.new
    er.load_data(input)
    assert_equal "COLORADO", er.economic_profiles[0].name
  end

  def test_finds_district_return_nil_missing_name
    er = EconomicProfileRepository.new
    er.load_data(input)
    assert_equal nil, er.find_by_name("Turing")
  end
  
  def test_finds_district_by_name
    er = EconomicProfileRepository.new
    er.load_data(input)
    assert_equal "ACADEMY 20", er.find_by_name("ACADEMY 20").name
  end
  
  def test_finds_lowercase_name
    er = EconomicProfileRepository.new
    er.load_data(input)
    assert_equal "ACADEMY 20", er.find_by_name("academy 20").name
  end
  
  def test_name_returns_nil_invalid_search
    er = EconomicProfileRepository.new
    er.load_data(input)
    assert_equal nil, er.find_by_name("Turing")
  end
  
  def test_reaches_to_district_repo_for_link
    dr = DistrictRepository.new
    dr.load_data(input)
    assert dr.districts[0].economic_profile != nil
  end
end