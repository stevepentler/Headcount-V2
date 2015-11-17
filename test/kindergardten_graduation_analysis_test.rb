require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/kindergarten_graduation_analysis'
require './lib/district'

class KindergartenGraduationAnalysisTest < Minitest::Test

  def district_repo
    dr = DistrictRepository.new
    dr.load_data({
     :enrollment => {
     :kindergarten => "./data/kindergartners_test_file.csv",
     :high_school_graduation => './data/hs_grad_test_file.csv'}})
    dr
  end

  def test_district_kindergarten_average_single_value
    dr = district_repo
    ha = HeadcountAnalyst.new(dr)
    assert_equal 1.2, ha.district_kindergarten_average("JOHNSTOWN-MILLIKEN RE-5J")
  end

  def test_district_kindergarten_average_multiple_values
    dr = district_repo
    ha = HeadcountAnalyst.new(dr)
    assert_equal 0.372, ha.district_kindergarten_average("ACADEMY 20")
  end

  def test_district_kindergarten_average_statwide_value
    dr = district_repo
    ha = HeadcountAnalyst.new(dr)
    assert_equal 0.53, ha.district_kindergarten_average("Colorado")
  end

  def test_kindergarden_state_comparison_greater_than_one
    dr = district_repo
    ha = HeadcountAnalyst.new(dr)
    assert_equal 2.264, ha.kindergarten_participation_rate_variation("JOHNSTOWN-MILLIKEN RE-5J", :against => "COLORADO")
  end

  def test_kindergarden_state_comparison_less_than_one
    dr = district_repo
    ha = HeadcountAnalyst.new(dr)
    assert_equal 0.701, ha.kindergarten_participation_rate_variation("ACADEMY 20", :against => "COLORADO")
  end

  def test_kindergarten_participation_rate_variation_trend
    dr = district_repo
    ha = HeadcountAnalyst.new(dr)
    expected_hash = {2007=>0.992, 2006=>1.05}
    assert_equal expected_hash, ha.kindergarten_participation_rate_variation_trend("ACADEMY 20", :against => "COLORADO")
  end

  def test_kg_hs_comparison_returns_integer
    dr = district_repo
    ha = HeadcountAnalyst.new(dr)
    assert_equal Float, ha.kindergarten_participation_against_high_school_graduation(:for => "ACADEMY 20").class
  end

  def test_kg_hs_comparison_for_single_district
    dr = district_repo
    ha = HeadcountAnalyst.new(dr)
    assert_equal 0.575 , ha.kindergarten_participation_against_high_school_graduation( "ACADEMY 20")
  end

  def test_kg_hs_comparison_for_single_district_part_two
    dr = district_repo
    ha = HeadcountAnalyst.new(dr)
    assert_equal 1.878 , ha.kindergarten_participation_against_high_school_graduation("JOHNSTOWN-MILLIKEN RE-5J")
  end

  def test_kg_hs_comparison_for_mismatched_years
    dr = district_repo
    ha = HeadcountAnalyst.new(dr)
    assert_equal 0.632, ha.kindergarten_participation_against_high_school_graduation("ADAMS COUNTY 14")
  end

  def test_kg_hs_correlation_returns_true_for_district_in_range
    dr = district_repo
    ha = HeadcountAnalyst.new(dr)
    assert_equal true, ha.kindergarten_participation_correlates_with_high_school_graduation(:for => "ADAMS COUNTY 14")
  end
def test_kg_hs_correlation_returns_true_for_another_district_in_range
   dr = district_repo
   ha = HeadcountAnalyst.new(dr)
   assert_equal true, ha.kindergarten_participation_correlates_with_high_school_graduation(:for => "ADAMS-ARAPAHOE 28J")
 end

 def test_kg_hs_correlation_returns_false_for_district_outside_range
   dr = district_repo
   ha = HeadcountAnalyst.new(dr)
   assert_equal false, ha.kindergarten_participation_correlates_with_high_school_graduation(:for => "JOHNSTOWN-MILLIKEN RE-5J")
 end

 def test_kg_hs_correlation_returns_false_for_statewide
   dr = district_repo
   ha = HeadcountAnalyst.new(dr)
   assert_equal false , ha.kindergarten_participation_correlates_with_high_school_graduation(:for => "STATEWIDE")
 end

 def test_across_three_districts
   dr = district_repo
   ha = HeadcountAnalyst.new(dr)
   assert_equal false , ha.kindergarten_participation_correlates_with_high_school_graduation(:across => ["ADAMS COUNTY 14", "JOHNSTOWN-MILLIKEN RE-5J", "ACADEMY 20"])
 end

 def test_across_four_districts
   dr = district_repo
   ha = HeadcountAnalyst.new(dr)
   assert_equal false , ha.kindergarten_participation_correlates_with_high_school_graduation(:across => ["ADAMS COUNTY 14", "JOHNSTOWN-MILLIKEN RE-5J", "ACADEMY 20", "ADAMS-ARAPAHOE 28J"])
 end

 def test_across_one_district
   dr = district_repo
   ha = HeadcountAnalyst.new(dr)
   assert_equal true , ha.kindergarten_participation_correlates_with_high_school_graduation(:across => ["ADAMS COUNTY 14"])
 end

 def test_across_two_districts_known_to_be_true
   dr = district_repo
   ha = HeadcountAnalyst.new(dr)
   assert_equal true , ha.kindergarten_participation_correlates_with_high_school_graduation(:across => ["ADAMS COUNTY 14", "ADAMS-ARAPAHOE 28J"])
 end

end
