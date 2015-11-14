require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/enrollment_repo'
require './lib/csv_parser'

class EnrollmentRepositoryTest < Minitest::Test

  def input
    csv = CSVParser.new({:enrollment => {
                :kindergarten => "./data/kindergartners_test_file.csv",
                :high_school_graduation => "./data/hs_grad_test_file.csv" 
               }
           })
    csv.parsed_csv
  end

  def test_repo_stores_object_name
    er = EnrollmentRepository.new
    er.load_data(input)
    assert_equal "ACADEMY 20", er.enrollments[0].name
  end

  def test_finds_district_return_nil_missing_name
    er = EnrollmentRepository.new
    er.load_data(input)
    assert_equal nil, er.find_by_name("Turing")
  end

  def test_finds_district_by_name
    er = EnrollmentRepository.new
    er.load_data(input)
    assert_equal "ACADEMY 20", er.find_by_name("ACADEMY 20").name
  end

  def test_finds_lowercase_name
    er = EnrollmentRepository.new
    er.load_data(input)
    assert_equal "ACADEMY 20", er.find_by_name("ACADEMY 20").name
  end

  def test_name_returns_nil_invalid_search
    er = EnrollmentRepository.new
    er.load_data(input)
    assert_equal nil, er.find_by_name("Turing")
  end
  # #
  # def test_reaches_to_district_repo_for_link
  #   dr = DistrictRepository.new
  #   dr.load_data({
  #     :enrollment => {
  #     :kindergarten => "./data/Kindergartners in full-day program.csv"}})
  #   assert true
  # end
end