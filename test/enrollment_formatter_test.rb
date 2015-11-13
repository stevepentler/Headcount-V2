require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/enrollment_formatter'

class EnrollmentFormatterTest < Minitest::Test

  def load_data
    ld = {
          :enrollment => {
            :high_school_graduation => "./data/High school graduation rates.csv",
            :kindergarten => "./data/kindergartners_test_file.csv"   
              }
          }
  end

  def test_creates_sub_hash_year_percent_for_single_line
    er = EnrollmentFormatter.new
    er.load_csv(load_data)
    hash = {2007 => 0.395}
    assert_equal hash, ef.pair_year_percentage({:location => "Colorado", :timeframe => 2007, :dataformat => "Percent", :data => 0.39465})
  end

  def test_pairs_name_and_pair_for_single_line
    skip
    ef = EnrollmentFormatter.new
    hash = {:name => "DISTRICT", :participation => {2010 => 0.392}}
    csv_line = {:location => "district", :timeframe => 2010, :dataformat => "Percent", :data => 0.3915}
    assert_equal hash, ef.pair_name_and_year_percentage(csv_line)
  end

  def test_pairs_name_and_pair_for_repeat_district_name
    skip
    ef = EnrollmentFormatter.new
    hash = {:name => "district", :participation => {2009 => 0.1}}
    csv_line = {:location => "district", :timeframe => 2010, :dataformat => "Percent", :data => 0.3915}
    hash_mod = {2009=>0.1, 2010=>0.392}
    assert_equal hash_mod, ef.pair_name_and_pair_for_repeat_district(csv_line, hash)
  end
end
