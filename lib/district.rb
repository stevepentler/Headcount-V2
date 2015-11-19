class District
  attr_reader :name
  attr_accessor :enrollment, :statewide_test, :economic_profile

  def initialize(district_data)
    @name = district_data[:name]
    @enrollment = nil
    @statewide_test = nil
    @economic_profile = nil
  end
end
