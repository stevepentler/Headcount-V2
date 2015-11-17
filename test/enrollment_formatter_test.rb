require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/enrollment_formatter'
require './lib/csv_parser'

class EnrollmentFormatterTest < Minitest::Test

  def load_data
    ld = {
          :enrollment => {
            :high_school_graduation => "./data/High school graduation rates.csv",
            :kindergarten => "./data/Kindergartners in full-day program.csv"
              }
          }
    csv_parser = CSVParser.new(ld)
    parsed_csv = csv_parser.parsed_csv
  end

  def test_parses_into_hash
    er = EnrollmentFormatter.new
    er.district_governor(load_data)
    binding.pry
  end

  # def test_creates_sub_hash_year_percent_for_single_line
  #   ef = EnrollmentFormatter.new
  #   hash = {2007 => 0.395}
  #   assert_equal hash, ef.yearly_data({:location => "Colorado", :timeframe => 2007, :dataformat => "Percent", :data => 0.39465})
  # end
  #
  # def test_district_yearly_data_returns_enrollment_object
  #   ef = EnrollmentFormatter.new
  #   row = {:location => "ACADEMY 20", :timeframe => 2010, :dataformat => "Percent", :data => 0.3915}
  #   assert_equal Enrollment, ef.district_yearly_data(:kindergarten, row).class
  # end
  #
  # def test_pairs_name_and_pair_for_repeat_district_name
  #   ef = EnrollmentFormatter.new
  #   object = Enrollment.new({:location => 'district', :timeframe => 2011,})
  #   row = {:location => "district", :timeframe => 2010, :dataformat => "Percent", :data => 0.3915}
  #   hash_mod = {2009=>0.1, 2010=>0.392}
  #   assert_equal hash_mod, ef.pair_name_and_pair_for_repeat_district(object, row)
  # end
end
