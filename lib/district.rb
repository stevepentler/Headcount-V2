class District 
  attr_reader :name
  attr_accessor :enrollment, :statewide_test

  def initialize(district_data)
    @name = district_data[:name]
    @enrollment = nil
    @statewide_test = nil
  end
end
