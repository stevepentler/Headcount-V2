require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/headcount_analyst'
require './lib/district'

class HeadcountAnalystTest < Minitest::Test

  def district_repo
    dr = DistrictRepository.new
    dr.load_csv({
     :enrollment => {
     :kindergarten => "./data/kindergartners_test_file.csv"}})
    dr
  end 

  def test_district_averages
    dr = district_repo
    ha = HeadcountAnalyst.new(dr)
    assert_equal 0.3, ha.district_average("ADAMS COUNTY 14")
  end 

  def test_kindergarden_participation_rate
    dr = district_repo
    ha = HeadcountAnalyst.new(dr)    
    assert_equal 2, ha.kindergarten_participation_rate_variation("ADAMS COUNTY 14", "COLORADO")
  end 

  def test_kindergarden_participation_rate
    dr = district_repo
    ha = HeadcountAnalyst.new(dr)    
    assert_equal 0.566, ha.kindergarten_participation_rate_variation("ADAMS COUNTY 14", "COLORADO")
  end 

  def test_kindergarten_participation_rate_variation_trend
    dr = district_repo
    ha = HeadcountAnalyst.new(dr)    
    expected_hash = {"2007"=>0.775, "2006"=>0.869, "2005"=>1.079}
    assert_equal expected_hash, ha.kindergarten_participation_rate_variation_trend("ADAMS COUNTY 14", "COLORADO")
  end
end

