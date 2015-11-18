require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/statewide_testing_repo'
require './lib/statewide_test'

class StatewideTestTest < Minitest::Test

  def input
    csv = {:statewide_testing => {
              :third_grade => "./data/3rd_grade_TCAP_test_file.csv",
              :eighth_grade => "./data/8th_grade_TCAP_test_file.csv",
              :math => "./data/ethnicity_math_test_file.csv",
              :reading => "./data/ethnicity_reading_test_file.csv",
              :writing => "./data/ethnicity_writing_test_file.csv"
                          }}
    csv
  end

  def test_proficient_by_grade_for_invalid_grade_raises_error
    st = StatewideTestingRepository.new
    st.load_data(input)
    assert_raises "UnknownDataError" do 
      st.statewide_tests[0].proficient_by_grade(9)
    end
  end 

  def test_proficient_by_grade_for_valid_grade
    st = StatewideTestingRepository.new
    st.load_data(input)
    expected_hash = {:math=>0.469, :reading=>0.703, :writing=>0.529}
    assert_equal expected_hash, st.statewide_tests[0].proficient_by_grade(8)[2008]
  end 

  def test_proficient_by_race_or_ethnicity_returns_float
    st = StatewideTestingRepository.new
    st.load_data(input)
    assert_equal Hash, st.statewide_tests[0].proficient_by_race_or_ethnicity(:asian).class
  end 

  def test_proficient_by_race_or_ethnicity_for_valid_race
    st = StatewideTestingRepository.new
    st.load_data(input)
    expected_hash = {:math=>0.709, :reading=>0.748, :writing=>0.656}
    assert_equal expected_hash, st.statewide_tests[0].proficient_by_race_or_ethnicity(:asian)[2011]
  end 

  def test_proficient_by_race_or_ethnicity_for_invalid_race_raises_error
    st = StatewideTestingRepository.new
    st.load_data(input)
    assert_equal 0.51, st.statewide_tests[0].proficient_for_subject_by_grade_in_year(:math, 8, 2010)
  end 

  def test_for_subject_by_grade_in_year_with_invalid_parameter_returns_error
    st = StatewideTestingRepository.new
    st.load_data(input)
    assert_raises "UnknownDataError" do 
      st.statewide_tests[0].proficient_for_subject_by_grade_in_year(:calligraphy, 8, 2010)
    end
  end 

  def test_for_subject_by_grade_in_year_with_valid_parameter_returns_float
    st = StatewideTestingRepository.new
    st.load_data(input)
    assert_raises "UnknownDataError" do 
      st.statewide_tests[0].proficient_for_subject_by_grade_in_year(:math, 8, 2010)
  end 

  def test_for_subject_by_grade_in_year_with_valid_parameter
  end 

  def test_proficient_for_subject_by_race_in_year_returns_float
  end 

  def test_proficient_for_subject_by_race_in_year_for_valid_race
  end 

  def test_proficient_for_subject_by_race_in_year_for_invalid_race
  end 

end 