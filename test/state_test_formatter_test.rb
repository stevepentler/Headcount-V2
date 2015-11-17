require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/enrollment_formatter'

class EnrollmentFormatterTest < Minitest::Test

  def input
    csv = CSVParser.new(:statewide_testing => {
                          :third_grade => "./data/3rd_grade_TCAP_test_file.csv",
                          :eigth_grade => "./data/8th_grade_TCAP_test_file.csv",
                          :math => "./data/ethnicity_math_test_file.csv",
                          :reading => "./data/ethnicity_reading_test_file.csv",
                          :writing => "./data/ethnicity_writing_test_file.csv"
                          })
    csv.parsed_csv
  end

  def test_creates_sub_hash_year_percent_for_single_line
    ef = EnrollmentFormatter.new
    hash = {2007 => 0.395}
    assert_equal hash, ef.yearly_data({:location => "Colorado", :timeframe => 2007, :dataformat => "Percent", :data => 0.39465})
  end

  def test_district_yearly_data_returns_enrollment_object
    ef = EnrollmentFormatter.new
    row = {:location => "ACADEMY 20", :timeframe => 2010, :dataformat => "Percent", :data => 0.3915}
    assert_equal Enrollment, ef.district_yearly_data(:kindergarten, row).class
  end

  # def test_pairs_name_and_pair_for_repeat_district_name
  #   ef = EnrollmentFormatter.new
  #   object = Enrollment.new({:location => 'district', :timeframe => 2011,})
  #   row = {:location => "district", :timeframe => 2010, :dataformat => "Percent", :data => 0.3915}
  #   hash_mod = {2009=>0.1, 2010=>0.392}
  #   assert_equal hash_mod, ef.pair_name_and_pair_for_repeat_district(object, row)
  # end
end
