require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/enrollment'

class EnrollmentTest < Minitest::Test

  def test_district_has_name
    e = Enrollment.new({:name => "Turing"})
    assert_equal "Turing", e.name
  end 

  def test_district_has_year_hash
    e = Enrollment.new({:name => "Turing", :participation => {2009 => 0.100, 2010 => 0.391}})
    hash = {2009 => 0.100, 2010 => 0.391}
    assert_equal hash, e.participation_years
  end

  def test_kindergarten_participation_by_year_returns_hash_class
     e = Enrollment.new({:name => "Turing", :participation => {2009 => 0.100, 2010 => 0.391}})
    assert_equal Hash, e.kindergarten_participation_by_year.class
  end

  def test_kindergarten_participation_by_year_returns_correct_hash
    e = Enrollment.new({:name => "Turing", :participation => {2009 => 0.100, 2010 => 0.391}})
    hash = {2009 => 0.100, 2010 => 0.391}
    assert_equal hash, e.kindergarten_participation_by_year
  end

  def test_kindergarten_participation_in_year
    e = Enrollment.new({:name => "Turing", :participation => {2009 => 0.100, 2010 => 0.391}})
    hash = {2009 => 0.100, 2010 => 0.391}
    assert_equal 0.1, e.kindergarten_participation_in_year(2009)
  end

  def test_test_kindergarten_participation_fails_with_unincluded_years
    e = Enrollment.new({:name => "Turing", :participation => {2009 => 0.100, 2010 => 0.391}})
    hash = {2009 => 0.100, 2010 => 0.391}
    assert_equal nil, e.kindergarten_participation_in_year(1901)
  end 

  def test_test_kindergarten_participation_fails_with_string_argument
    e = Enrollment.new({:name => "Turing", :participation => {2009 => 0.100, 2010 => 0.391}})
    hash = {2009 => 0.100, 2010 => 0.391}
    assert_equal nil, e.kindergarten_participation_in_year("2009")
  end
end 