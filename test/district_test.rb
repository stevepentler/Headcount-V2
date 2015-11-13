require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/district'

class DistrictTest < Minitest::Test

  def test_district_has_name
    d = District.new({:name => "Turing"})
    assert_equal "Turing", d.name
  end 
end 