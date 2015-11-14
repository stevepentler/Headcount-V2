require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/kindergarten_analysis'
require './lib/district'

class KindergartenAnalysisTest < Minitest::Test

  def district_repo
    dr = DistrictRepository.new
    dr.load_csv({
     :enrollment => {
     :kindergarten => "./data/kindergartners_test_file.csv",
     :high_school_graduation => './data/hs_grad_test_file.csv'}})
    dr
  end 

  def test_district_kindergarten_average_single_value
    dr = district_repo
    ka = KindergartenAnalysis.new(dr)
    assert_equal 1.2, ka.kindergarten_average("JOHNSTOWN-MILLIKEN RE-5J")
  end 

  def test_kindergarten_average_multiple_values
    dr = district_repo
    ka = KindergartenAnalysis.new(dr)
    assert_equal 0.373, ka.kindergarten_average("ACADEMY 20")
  end

  def test_kindergarten_average_statwide_value
    dr = district_repo
    ka = KindergartenAnalysis.new(dr)
    assert_equal 0.53, ka.kindergarten_average("Colorado")
  end

  def test_kindergarden_state_comparison_greater_than_one
    dr = district_repo
    ka = KindergartenAnalysis.new(dr)    
    assert_equal 2.264, ka.kindergarten_state_comparison("JOHNSTOWN-MILLIKEN RE-5J", "COLORADO")
  end 

   def test_kindergarden_state_comparison_less_than_one
    dr = district_repo
    ka = KindergartenAnalysis.new(dr)    
    assert_equal 0.704, ka.kindergarten_state_comparison("ACADEMY 20", "COLORADO")
  end

  def test_kindergarten_participation_rate_variation_trend_count_for_three_values
    dr = district_repo
    ka = KindergartenAnalysis.new(dr)    
    assert_equal 3, ka.kindergarten_rate_variation_trend("ADAMS COUNTY 14", "COLORADO").count
  end

  def test_kindergarten_participation_rate_variation_trend
    dr = district_repo
    ka = KindergartenAnalysis.new(dr)    
    expected_hash = {"2007"=>0.775, "2006"=>0.869, "2005"=>1.079}
    assert_equal expected_hash, ka.kindergarten_rate_variation_trend("ADAMS COUNTY 14", "COLORADO")
  end

end 