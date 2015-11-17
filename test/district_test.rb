require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/district'
require 'pry'

class DistrictTest < Minitest::Test

  def load_data
  ld = {:name => "ACADEMY 20", :timeframe => 2007, :dataformat => "Percent", :data => 0.39465}
  end

  def test_district_has_name
    d = District.new(load_data)
    assert_equal "ACADEMY 20", d.name
  end 
end 