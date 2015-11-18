require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/headcount_analyst'
require './lib/district'

class HeadcountAnalystTest < Minitest::Test

  def district_repo
    dr = DistrictRepository.new
    dr.load_data({
          :enrollment => {
              :kindergarten => "./data/kindergartners_test_file.csv",
              :high_school_graduation => "./data/hs_grad_test_file.csv"
              },
          :statewide_testing => {
              :third_grade => "./data/3rd_grade_TCAP_test_file.csv",
              :eighth_grade => "./data/8th_grade_TCAP_test_file.csv",
              :math => "./data/ethnicity_math_test_file.csv",
              :reading => "./data/ethnicity_reading_test_file.csv",
              :writing => "./data/ethnicity_writing_test_file.csv"
              }})
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

   def test_raises_error_without_grade
    ha = HeadcountAnalyst.new(district_repo)
    assert_raises "InsufficientInformationError: A grade must be provided to answer this question" do
      ha.top_statewide_test_year_over_year_growth(subject: :math)
    end 
  end

  def test_raises_error_with_invalid_grade
    ha = HeadcountAnalyst.new(district_repo)
    assert_raises "UnknownDataError: 9 is not a known grade" do
      ha.top_statewide_test_year_over_year_growth(grade: 9, subject: :math)
    end 
  end

  def test_find_single_leader_returns_array
    ha = HeadcountAnalyst.new(district_repo)
    assert_equal Array, ha.top_statewide_test_year_over_year_growth(grade: 3, subject: :math).class
  end 

  def test_find_single_leader_returns_array_with_two_elements
    ha = HeadcountAnalyst.new(district_repo)
    assert_equal 2, ha.top_statewide_test_year_over_year_growth(grade: 3, subject: :math).count
  end 

  def test_find_single_leader_district_array_name_first
    ha = HeadcountAnalyst.new(district_repo)
    assert_equal String, ha.top_statewide_test_year_over_year_growth(grade: 3, subject: :math).first.class
  end 

  def test_find_single_leader_district_array_value_last
    ha = HeadcountAnalyst.new(district_repo)
    assert_equal Float, ha.top_statewide_test_year_over_year_growth(grade: 3, subject: :math).last.class
  end 

  def test_find_single_leader
    ha = HeadcountAnalyst.new(district_repo)
    assert_equal ["ADAMS-ARAPAHOE 28J", 0.004], ha.top_statewide_test_year_over_year_growth(grade: 3, subject: :math)
  end

  def test_find_single_leader_different_grade_and_subject
    ha = HeadcountAnalyst.new(district_repo)
    assert_equal ["ADAMS-ARAPAHOE 28J", 0.014], ha.top_statewide_test_year_over_year_growth(grade: 8, subject: :writing)
  end

  def test_across_all_subjects_returns_array
    ha = HeadcountAnalyst.new(district_repo)
    assert_equal Array, ha.top_statewide_test_year_over_year_growth(grade: 3).class
  end 

  def test_across_all_subjects_returns_single_element
    ha = HeadcountAnalyst.new(district_repo)
    assert_equal 2, ha.top_statewide_test_year_over_year_growth(grade: 3).count
  end 

  def test_across_all_subjects_array_name_first
    ha = HeadcountAnalyst.new(district_repo)
    assert_equal String, ha.top_statewide_test_year_over_year_growth(grade: 3).first.class
  end 

  def test_across_all_subjects_array_value_last
    ha = HeadcountAnalyst.new(district_repo)
    assert_equal Float, ha.top_statewide_test_year_over_year_growth(grade: 3).last.class
  end 

  def test_across_all_subjects_single_leader
    ha = HeadcountAnalyst.new(district_repo)
    assert_equal ["ACADEMY 20", -0.006], ha.top_statewide_test_year_over_year_growth(grade: 3)
  end 

  def test_find_multiple_leaders_returns_array
    ha = HeadcountAnalyst.new(district_repo)
    assert_equal Array, ha.top_statewide_test_year_over_year_growth(grade: 3, top: 3).class
  end 

  def test_find_multiple_leaders_returns_correct_count_of_three_elements
    ha = HeadcountAnalyst.new(district_repo)
    assert_equal 3, ha.top_statewide_test_year_over_year_growth(grade: 3, top: 3).count
    assert_equal 2, ha.top_statewide_test_year_over_year_growth(grade: 3, top: 2).count
  end 

  def test_find_multiple_leaders_returns_correct_count_of_two_elements
    ha = HeadcountAnalyst.new(district_repo)
    assert_equal 2, ha.top_statewide_test_year_over_year_growth(grade: 3, top: 2).count
  end 

  def test_find_multiple_leaders_across_subject
    ha = HeadcountAnalyst.new(district_repo)
    assert_equal 2, ha.top_statewide_test_year_over_year_growth(grade: 8, subject: :writing, top: 2).count
  end

  def test_find_multiple_leaders
    ha = HeadcountAnalyst.new(district_repo)
    assert_equal [["ACADEMY 20", 0.002], ["ADAMS-ARAPAHOE 28J", 0.014]], ha.top_statewide_test_year_over_year_growth(grade: 8, subject: :writing, top: 2)
  end 

  def test_unequal_weighting
     ha = HeadcountAnalyst.new(district_repo)
    assert_equal ["ACADEMY 20", -0.005], ha.top_statewide_test_year_over_year_growth(grade: 3, :weighting => {:math => 0.5, :reading => 0.5, :writing => 0.0})
  end 


end
