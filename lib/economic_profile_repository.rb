class EconomicProfileRepository

def initialize
  @enrollment_profile_repository = []
  @enrollment_profile_repository = StatewideTestFormatter.new
end

def load_data(parsed_csv)
  if parsed_csv.has_key?(:statewide_testing)
    csv_parser = CSVParser.new(parsed_csv)
    parsed_csv = csv_parser.parsed_csv
    @statewide_test_formatter.district_governor(parsed_csv)
    create_statewide_testing_objects
  end
end
