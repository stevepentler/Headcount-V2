# require 'minitest'
# require 'minitest/autorun'
# require 'minitest/pride'
# require './lib/statewide_testing_analysis'
# # require './lib/district'

# class StatewideTestingAnalysisTest < MiniTest::Test \

#    def load_data
#     ld = {
#           :statewide_testing => {
#               :third_grade => "./data/3rd_grade_TCAP_test_file.csv",
#               :eigth_grade => "./data/8th_grade_TCAP_test_file.csv",
#               :math => "./data/ethnicity_math_test_file.csv",
#               :reading => "./data/ethnicity_reading_test_file.csv",
#               :writing => "./data/ethnicity_writing_test_file.csv"
#               }
#             }
#   end


#   def test_top_statewide_growth_one_year_by_subject
#     st = StatewideTestingAnalysis.new
#     assert_equal ["district_name", 123], st.statewide_test_year_over_year_growth(grade: 3, subject: :math)
#   end


end
