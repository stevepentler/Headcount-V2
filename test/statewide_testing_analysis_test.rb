require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/statewide_testing_analysis'
require './lib/statewide_testing_repo'

class StatewideTestingAnalysisTest < MiniTest::Test

  def district_repo
    dr = StatewideTestRepository.new
    dr.load_data({
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
    assert_equal "InsufficientInformationError: A grade must be provided to answer this question", st.top_statewide_test_year_over_year_growth(subject: :math)
  end

  def test_raises_different_error_for_incorrect_grade
    st = StatewideTestingAnalysis.new(district_repo)
    assert_equal "UnknownDataError: 9 is not a known grade", st.top_statewide_test_year_over_year_growth(grade: 9, subject: :math)
  end

  def test_top_statewide_growth_one_year_by_subject
    st = StatewideTestingAnalysis.new(district_repo)
    assert_equal ["district_name", 123], st.top_statewide_test_year_over_year_growth(grade: 3, subject: :math)
  end
end
