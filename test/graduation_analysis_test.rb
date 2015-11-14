require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/graduation_analysis'
require './lib/district'

class GraduationAnalysisTest < Minitest::Test

  def district_repo
    dr = DistrictRepository.new
    dr.load_csv({
     :enrollment => {
     :kindergarten => "./data/kindergartners_test_file.csv",
     :high_school_graduation => './data/hs_grad_test_file.csv'}})
    dr
  end 

  def test_district_graduation_average_single_value
    dr = district_repo
    ga = GraduationAnalysis.new(dr)
    assert_equal 0.659, ga.graduation_average("ADAMS COUNTY 14")
  end 

  def test_graduation_average_multiple_values
    dr = district_repo
    ga = GraduationAnalysis.new(dr)
    assert_equal 0.901, ga.graduation_average("ACADEMY 20")
  end

  def test_graduation_average_statwide_value
    dr = district_repo
    ga = GraduationAnalysis.new(dr)
    assert_equal 0.739, ga.graduation_average("Colorado")
  end

  def test_kindergarden_state_comparison_greater_than_one
    dr = district_repo
    ga = GraduationAnalysis.new(dr)    
    assert_equal 1.219, ga.graduation_state_comparison("ACADEMY 20", "COLORADO")
  end 

   def test_kindergarden_state_comparison_less_than_one
    dr = district_repo
    ga = GraduationAnalysis.new(dr)    
    assert_equal 0.636, ga.graduation_state_comparison("ADAMS-ARAPAHOE 28J", "COLORADO")
  end

  def test_graduation_participation_rate_variation_trend_count_for_mismatched_years
    dr = district_repo
    ga = GraduationAnalysis.new(dr)    
    assert_equal 3, ga.graduation_rate_variation_trend("ACADEMY 20", "COLORADO").count
  end

  def test_graduation_participation_rate_variation_trend
    dr = district_repo
    ga = GraduationAnalysis.new(dr)    
    expected_hash = {"2012"=>1.238, "2013"=>"No Comparison", "2014"=>1.162}
    assert_equal expected_hash, ga.graduation_rate_variation_trend("ACADEMY 20", "COLORADO")
  end

  def test_graduation_participation_rate_variation_trend_for_no_overlapping_years
    dr = district_repo
    ga = GraduationAnalysis.new(dr)   
    expected_hash = {"2010"=>"No Comparison", "2011"=>"No Comparison"}  
    assert_equal expected_hash, ga.graduation_rate_variation_trend("ADAMS-ARAPAHOE 28J", "ADAMS COUNTY 14")  
  end
end 