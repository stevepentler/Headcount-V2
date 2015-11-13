require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/csv_parser'


class CSVParserTest < Minitest::Test

  def load_data
    ld = {
          :enrollment => {
              :kindergarten => "./data/kindergartners_test_file.csv",
              :high_school_graduation => "./data/hs_grad_test_file.csv" 
              }
          }
  end

  def test_seperate_category_has_rows
    p = CSVParser.new(load_data)
    p.seperate_category
    output = p.parsed_csv
    assert output[:enrollment][:kindergarten].count > 5
    assert output[:enrollment][:high_school_graduation].count > 5
  end

end