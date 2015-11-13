require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/enrollment_repo'

class EnrollmentRepositoryTest < Minitest::Test

  def input
    {:kindergarten =>
      [{:name => "ACADEMY 20", :participation => {2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677}}]
    }
  end

  def test_repo_stores_object_name
    er = EnrollmentRepository.new
    er.import_data(input)
    assert_equal "ACADEMY 20", er.enrollments[0].name
  end

  def test_finds_district_return_nil_missing_name
    er = EnrollmentRepository.new
    er.import_data(input)
    assert_equal nil, er.find_by_name("Turing")
  end

  def test_finds_district_by_name
    er = EnrollmentRepository.new
    er.import_data(input)
    assert_equal "ACADEMY 20", er.find_by_name("ACADEMY 20").name
  end

  def test_finds_lowercase_name
    er = EnrollmentRepository.new
    er.import_data(input)
    assert_equal "ACADEMY 20", er.find_by_name("Academy 20").name
  end

  def test_name_returns_nil_invalid_search
    er = EnrollmentRepository.new
    er.import_data(input)
    assert_equal nil, er.find_by_name("Turing")
  end
  #
  # def test_reaches_to_district_repo_for_link
  #   dr = DistrictRepository.new
  #   dr.load_data({
  #     :enrollment => {
  #     :kindergarten => "./data/Kindergartners in full-day program.csv"}})
  #   assert true
  # end
end