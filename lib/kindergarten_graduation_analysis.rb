require_relative 'district_repo'

class KindergartenGraduationAnalysis
  
  attr_reader :district_repo
  def initialize(district_repo)
    @district_repo = district_repo
  end 



###basically pseudocode###############
  def correlation(district)
    correlation = kindergarten_participation_against_high_school_graduation(district[:for])
      (correlation  > 0.6 && correlation < 1.5)
  end

  def correlation_for_multiple_districts?(district)
    correlations = district_repo.map do |district|
      kindergarten_participation_against_high_school_graduation(district)
    end 
    correlations.compact
    correlations.count(true) / district_repo.length > 7
  end 

  def statewide_correlation
    district = district_repo.names - "Colorado"
    kindergarten_participation_against_high_school_graduation(district)
  end 

end 


