require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/statewide_test_formatter'
require './lib/csv_parser'

class StatewideTestFormatterTest < Minitest::Test

  def load_data
    ld =
      {:statewide_testing => {
                            :third_grade => "./data/3rd_grade_TCAP_test_file.csv",
                            :eighth_grade => "./data/8th_grade_TCAP_test_file.csv",
                            :math => "./data/ethnicity_math_test_file.csv",
                            :reading => "./data/ethnicity_reading_test_file.csv",
                            :writing => "./data/ethnicity_writing_test_file.csv"
                            }}
    csv_parser = CSVParser.new(ld)
    parsed_csv = csv_parser.parsed_csv
  end

  def test_parses_into_hash
    er = StatewideTestFormatter.new
  end
end
