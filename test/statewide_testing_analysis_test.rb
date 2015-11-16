require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/statewide_testing_analysis'
# require './lib/district'

class StatewideTestingAnalysisTest < MiniTest::Test \

   def load_data
    ld = {
          :statewide_testing => {
              :third_grade => "./data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv",
              :eigth_grade => "./data/8th grade students scoring proficient or above on the CSAP_TCAP.csv",
              :math => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv",
              :reading => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv",
              :writing => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv"
              }
            }
  end

  def test_top_statewide_growth_one_year_by_subject
    st = StatewideTestingAnalysis.new
    assert_equal ["district_name", 123], st.statewide_test_year_over_year_growth(grade: 3, subject: :math)
  end 





end 

