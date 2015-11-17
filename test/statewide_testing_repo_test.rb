require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/statewide_testing_repo'
require './lib/csv_parser'
require './lib/district_repository'

class StatewideTestingRepositoryTest < Minitest::Test

  def input
    csv = {
      :enrollment => {
              :kindergarten => "./data/Kindergartners in full-day program.csv"},
      :statewide_testing => {
              :third_grade => "./data/3rd_grade_TCAP_test_file.csv",
              :eighth_grade => "./data/8th_grade_TCAP_test_file.csv",
              :math => "./data/ethnicity_math_test_file.csv",
              :reading => "./data/ethnicity_reading_test_file.csv",
              :writing => "./data/ethnicity_writing_test_file.csv"
                          }}
    csv
  end

  def test_repo_stores_object_name
    er = StatewideTestingRepository.new
    er.load_data(input)
    assert_equal "COLORADO", er.statewide_tests[0].name
  end

  def test_finds_district_return_nil_missing_name
    er = StatewideTestingRepository.new
    er.load_data(input)
    assert_equal nil, er.find_by_name("Turing")
  end
  
  def test_finds_district_by_name
    er = StatewideTestingRepository.new
    er.load_data(input)
    assert_equal "ACADEMY 20", er.find_by_name("ACADEMY 20").name
  end
  
  def test_finds_lowercase_name
    er = StatewideTestingRepository.new
    er.load_data(input)
    assert_equal "ACADEMY 20", er.find_by_name("ACADEMY 20").name
  end
  
  def test_name_returns_nil_invalid_search
    er = StatewideTestingRepository.new
    er.load_data(input)
    assert_equal nil, er.find_by_name("Turing")
  end
  
  def test_reaches_to_district_repo_for_link
    dr = DistrictRepository.new
    dr.load_data(input)
    assert_equal 1, dr.districts[0]
  end
end