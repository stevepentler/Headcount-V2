require_relative "district_repo"

class District 
  attr_reader :name
  attr_accessor :enrollment, :testing

  def initialize(district_data)
    @name = district_data[:location]
    @enrollment = nil
    @testing = nil
  end
end
