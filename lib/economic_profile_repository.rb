require_relative "economic_profile_formatter"
require_relative "economic_profile"

class EconomicProfileRepository

  attr_reader :economic_profiles

  def initialize
    @economic_profiles = []
    @economic_profile_formatter = EconomicProfileFormatter.new
  end

  def load_data(parsed_csv)
    if parsed_csv.has_key?(:economic_profile)
      csv_parser = CSVParser.new(parsed_csv)
      parsed_csv = csv_parser.parsed_csv
      @economic_profile_formatter.district_governor(parsed_csv)
      create_economic_profile_testing_objects
    end
  end

  def create_economic_profile_testing_objects
    @economic_profile_formatter.economic_profiles_hash.each do |profile| ###what do we call on formatter?
      @economic_profiles << EconomicProfile.new(profile)
    end
  end

  def find_by_name(name)
    @economic_profiles.find do |profile|
      name.upcase == profile.name.upcase
    end
  end
end