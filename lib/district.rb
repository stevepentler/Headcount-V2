class District 
  attr_reader :name
  attr_accessor :enrollment, :statewide_testing

  def initialize(district_data)
    @name = district_data[:name]
    @enrollment = nil
    @statewide_testing = nil
  end
end
