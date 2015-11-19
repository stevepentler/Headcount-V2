require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/statewide_testing_analysis'
require './lib/district_repository'
require './lib/statewide_testing_repo'

class StatewideTestingAnalysisTest < MiniTest::Test

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

  def test_raises_error_without_grade
    st = StatewideTestingAnalysis.new(district_repo)
    assert_raises "InsufficientInformationError: A grade must be provided to answer this question" do
      st.top_statewide_testing(subject: :math)
    end 
  end

  def test_raises_error_with_invalid_grade
    st = StatewideTestingAnalysis.new(district_repo)
    assert_raises "UnknownDataError: 9 is not a known grade" do
      st.top_statewide_testing(grade: 9, subject: :math)
    end 
  end

  def test_find_single_leader_returns_array
    st = StatewideTestingAnalysis.new(district_repo)
    assert_equal Array, st.top_statewide_testing(grade: 3, subject: :math).class
  end 

  def test_find_single_leader_returns_array_with_two_elements
    st = StatewideTestingAnalysis.new(district_repo)
    assert_equal 2, st.top_statewide_testing(grade: 3, subject: :math).count
  end 

  def test_find_single_leader_district_array_name_first
    st = StatewideTestingAnalysis.new(district_repo)
    assert_equal String, st.top_statewide_testing(grade: 3, subject: :math).first.class
  end 

  def test_find_single_leader_district_array_value_last
    st = StatewideTestingAnalysis.new(district_repo)
    assert_equal Float, st.top_statewide_testing(grade: 3, subject: :math).last.class
  end 

  def test_find_single_leader
    st = StatewideTestingAnalysis.new(district_repo)
    assert_equal ["ADAMS-ARAPAHOE 28J", 0.0043333333333333375], st.top_statewide_testing(grade: 3, subject: :math)
  end

  def test_find_single_leader_different_grade_and_subject
    st = StatewideTestingAnalysis.new(district_repo)
    assert_equal ["ADAMS-ARAPAHOE 28J", 0.01416666666666666], st.top_statewide_testing(grade: 8, subject: :writing)
  end

  def test_across_all_subjects_returns_array
    st = StatewideTestingAnalysis.new(district_repo)
    assert_equal Array, st.top_statewide_testing(grade: 3).class
  end 

  def test_across_all_subjects_returns_single_element
    st = StatewideTestingAnalysis.new(district_repo)
    assert_equal 2, st.top_statewide_testing(grade: 3).count
  end 

  def test_across_all_subjects_array_name_first
    st = StatewideTestingAnalysis.new(district_repo)
    assert_equal String, st.top_statewide_testing(grade: 3).first.class
  end 

  def test_across_all_subjects_array_value_last
    st = StatewideTestingAnalysis.new(district_repo)
    assert_equal Float, st.top_statewide_testing(grade: 3).last.class
  end 

  def test_across_all_subjects_single_leader
    st = StatewideTestingAnalysis.new(district_repo)
    assert_equal ["ADAMS-ARAPAHOE 28J", 0.0], st.top_statewide_testing(grade: 3)
  end 

  # def test_find_multiple_leaders_returns_array
  #   st = StatewideTestingAnalysis.new(district_repo)
  #   assert_equal Array, st.top_statewide_testing(grade: 3, top: 3).class
  # end 

  # def test_find_multiple_leaders_returns_correct_count_of_three_elements
  #   st = StatewideTestingAnalysis.new(district_repo)
  #   assert_equal 3, st.top_statewide_testing(grade: 3, top: 3).count
  #   assert_equal 2, st.top_statewide_testing(grade: 3, top: 2).count
  # end 

  # def test_find_multiple_leaders_returns_correct_count_of_two_elements
  #   st = StatewideTestingAnalysis.new(district_repo)
  #   assert_equal 2, st.top_statewide_testing(grade: 3, top: 2).count
  # end 

  # def test_find_multiple_leaders_across_subject
  #   st = StatewideTestingAnalysis.new(district_repo)
  #   assert_equal 2, st.top_statewide_testing(grade: 8, subject: :writing, top: 2).count
  # end

  # def test_find_multiple_leaders
  #   st = StatewideTestingAnalysis.new(district_repo)
  #   assert_equal [["ACADEMY 20", 0.002], ["ADAMS-ARAPAHOE 28J", 0.014]], st.top_statewide_testing(grade: 8, subject: :writing, top: 2)
  # end 

  # def test_unequal_weighting
  #    st = StatewideTestingAnalysis.new(district_repo)
  #   assert_equal ["ACADEMY 20", -0.005], st.top_statewide_testing(grade: 3, :weighting => {:math => 0.5, :reading => 0.5, :writing => 0.0})
  # end 


end
