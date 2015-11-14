require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/headcount_analyst'
require './lib/district'

class HeadcountAnalystTest < Minitest::Test

  def district_repo
    dr = DistrictRepository.new
    dr.load_csv({
     :enrollment => {
     :kindergarten => "./data/kindergartners_test_file.csv",
     :high_school_graduation => './data/hs_grad_test_file.csv'}})
    dr
  end 

  #################moved to kindergarten analysis test ################

  # def test_district_kg_average   
  #   dr = district_repo
  #   ha = HeadcountAnalyst.new(dr)
  #   assert_equal 0.3, ha.district_kindergarten_average("ADAMS COUNTY 14")
  # end 

  # def test_kindergarden_participation_rate
  #   dr = district_repo
  #   ha = HeadcountAnalyst.new(dr)    
  #   assert_equal 2, ha.kindergarten_participation_rate_variation("ADAMS COUNTY 14", "COLORADO")
  # end 

  # def test_kindergarden_participation_rate
  #   dr = district_repo
  #   ha = HeadcountAnalyst.new(dr)    
  #   assert_equal 0.566, ha.kindergarten_participation_rate_variation("ADAMS COUNTY 14", "COLORADO")
  # end 

  # def test_kindergarten_participation_rate_variation_trend
  #   dr = district_repo
  #   ha = HeadcountAnalyst.new(dr)    
  #   expected_hash = {"2007"=>0.775, "2006"=>0.869, "2005"=>1.079}
  #   assert_equal expected_hash, ha.kindergarten_participation_rate_variation_trend("ADAMS COUNTY 14", "COLORADO")
  # end

  def test_kg_hs_comparison_returns_integer
    dr = district_repo
    ha = HeadcountAnalyst.new(dr)
    assert_equal Float, ha.kindergarten_participation_against_high_school_graduation("ACADEMY 20").class
  end 

  def test_kg_hs_comparison_for_single_district
    dr = district_repo
    ha = HeadcountAnalyst.new(dr)
    assert_equal 0.578 , ha.kindergarten_participation_against_high_school_graduation("ACADEMY 20")
  end 

  def test_kg_hs_comparison_for_single_district_part_two
    dr = district_repo
    ha = HeadcountAnalyst.new(dr)
    assert_equal 1.88 , ha.kindergarten_participation_against_high_school_graduation("JOHNSTOWN-MILLIKEN RE-5J")
  end 

  def test_kg_hs_comparison_for_colorado_against_colorado_equals_one
    dr = district_repo
    ha = HeadcountAnalyst.new(dr)
    assert_equal 1 , ha.kindergarten_participation_against_high_school_graduation("COLORADO")
  end 

  def test_kg_hs_comparison_for_mismatched_years
    dr = district_repo
    ha = HeadcountAnalyst.new(dr)
    assert_equal 0.635, ha.kindergarten_participation_against_high_school_graduation("ADAMS COUNTY 14")
  end 

  def test_kg_hs_correlation_returns_true_for_district_in_range
    dr = district_repo
    ha = HeadcountAnalyst.new(dr)
    assert_equal true, ha.kindergarten_participation_correlates_with_high_school_graduation("ADAMS COUNTY 14")
  end 

  def test_kg_hs_correlation_returns_false_for_district_outside_range
    dr = district_repo
    ha = HeadcountAnalyst.new(dr)
    assert_equal false, ha.kindergarten_participation_correlates_with_high_school_graduation("JOHNSTOWN-MILLIKEN RE-5J")
  end 

  def test_kg_hs_correlation_statewide_true_for_seventy_percent_plus
  end 

  def test_kg_hs_correlation_statewide_false_for_less_than_seventy_percent
  end

  def test_kg_hs_correlation_multiple_districts_returns_boolean
  end 

  def test_kg_hs_correlation_multiple_districts_true_for_seventy_percent_plus
  end 

  def test_kg_hs_correlation_multiple_districts_false_for_less_than_seventy_percent
  end
end 

