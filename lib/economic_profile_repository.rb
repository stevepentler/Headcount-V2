require_relative "economic_profile_formatter"

class EconomicProfileRepository

  def initialize
    @economic_profils = []
    @economic_profile_repository = EconomicProfileFormatter.new
  end

def load_data(parsed_csv)
  if parsed_csv.has_key?(:statewide_testing)
    csv_parser = CSVParser.new(parsed_csv)
    parsed_csv = csv_parser.parsed_csv
    @economic_profile_repository.district_governor(parsed_csv)
  end
end
