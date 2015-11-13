require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/district_repo'

class DistrictRepoTest < Minitest::Test

  def test_repo_stores_object_name
    dr = DistrictRepository.new
    dr.import_data([{:name => "ACADEMY 20", :kindergarten_participation => {2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677}}])
    assert_equal "ACADEMY 20", dr.district_bin[0].name
  end
  
  def test_finds_district_return_nil_missing_name
    dr = DistrictRepository.new
    dr.import_data([{:name => "ACADEMY 20", :kindergarten_participation => {2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677}}])
    assert_equal nil, dr.find_by_name("Turing")
  end
  
  def test_finds_district_by_name
    dr = DistrictRepository.new
    dr.import_data([{:name => "ACADEMY 20", :kindergarten_participation => {2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677}}])
    assert_equal "ACADEMY 20", dr.find_by_name("ACADEMY 20").name
  end
  
  def test_finds_lowercase_name
    dr = DistrictRepository.new
    dr.import_data([{:name => "ACADEMY 20", :kindergarten_participation => {2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677}}])
    assert_equal "ACADEMY 20", dr.find_by_name("Academy 20").name
  end
  
  def test_name_returns_nil_invalid_search
    dr = DistrictRepository.new
    dr.import_data([{:name => "ACADEMY 20", :kindergarten_participation => {2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677}}])
    assert_equal nil, dr.find_by_name("Turing")
  end
  
  def test_find_all_matching
    dr = DistrictRepository.new
    dr.import_data([{:name => "ACAD"}, {:name => "turing"}, {:name => "ACADEMY 20", :kindergarten_participation => {2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677}}])
    assert_equal 2, dr.find_all_matching("acad").count
  end
  
  def test_find_all_matching
    dr = DistrictRepository.new
    dr.import_data([{:name => "ACAD"}, {:name => "turing"}, {:name => "ACADEMY 20", :kindergarten_participation => {2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677}}])
    assert_equal [], dr.find_all_matching("NOTASCHOOL")
  end

  def test_loads_data_returns_district_name_when_called
   dr = DistrictRepository.new
   dr.load_data({
     :enrollment => {
     :kindergarten => "./data/Kindergartners in full-day program.csv"}})
   assert_equal "ACADEMY 20", dr.find_by_name("Academy 20").name
  end

   def test_find_district_by_name_returns_district_object
   dr = DistrictRepository.new
   dr.load_data({
     :enrollment => {
     :kindergarten => "./data/Kindergartners in full-day program.csv"}})
   assert_equal District, dr.find_by_name("Academy 20").class
  end
end