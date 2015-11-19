require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/economic_profile_formatter'
require './lib/csv_parser'

class EconomicProfileFormatterTest < Minitest::Test

  def load_data
    ld = {
          :enrollment => {
            :high_school_graduation => "./data/High school graduation rates.csv",
            :kindergarten => "./data/Kindergartners in full-day program.csv"
          },
          :economic_profile => {
            :median_household_income => "./data/median_household_income_test_file.csv",
            :children_in_poverty => "./data/children_in_poverty_test_file.csv",
            :free_or_reduced_price_lunch => "./data/free_reduced_test_file.csv",
            :title_i => "./data/title_one_test_file.csv"
            }
          }

    csv_parser = CSVParser.new(ld)
    parsed_csv = csv_parser.parsed_csv
  end

  def test_parses_into_hash
    er = EconomicProfileFormatter.new
    er.district_governor(load_data)
  end


  #
  # def test_creates_sub_hash_year_percent_for_single_line
  #   ef = EconomicProfileFormatter.new
  #   hash = {2007 => 0.39465}
  #   assert_equal hash, ef.yearly_data({:location => "Colorado", :timeframe => 2007, :dataformat => "Percent", :data => 0.39465})
  # end
  #
  # def test_district_yearly_data_returns_enrollment_object
  #   ef = EconomicProfileFormatter.new
  #   row = {:location => "ACADEMY 20", :timeframe => 2010, :dataformat => "Percent", :data => 0.3915}
  #   assert_equal Array, ef.district_yearly_data(:kindergarten, row).class
  # end

  # def test_pairs_name_and_pair_for_repeat_district_name
  #   ef = EconomicProfileFormatter.new
  #   object = {:kindergarten_data => {:timeframe => {2009 => 0.1}}}
  #   row = {:timeframe => {2010 => 0.391}}
  #   hash_mod = {2009=>0.1, 2010=>0.391}
  #   assert_equal hash_mod, ef.merge_enroll_data(object, :kindergarten_data, row)
  # end
end
