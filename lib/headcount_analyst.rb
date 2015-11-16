require 'kindergarten_graduation_analysis'

class HeadcountAnalyst

  include KeywordParser

  attr_reader :kindergarten_graduation_analysis

  def initialize(district_repo)
    @kindergarten_graduation_analysis = KindergartenGraduationAnalysis.new(district_repo)
  end

  def district_kindergarten_average(district)
    kindergarten_graduation_analysis.district_kindergarten_average(district)
  end

  def kindergarten_participation_rate_variation(district1, district2)
    kindergarten_graduation_analysis.kindergarten_participation_rate_variation(district1, district2)
  end

  def kindergarten_participation_rate_variation_trend(district1, district2)
    kindergarten_graduation_analysis.kindergarten_participation_rate_variation_trend(district1, district2)
  end

  def graduation_participation_rate_variation(district1, district2)
    kindergarten_graduation_analysis.graduation_participation_rate_variation(district1, district2)
  end

  def kindergarten_participation_against_high_school_graduation(district)
    kindergarten_graduation_analysis.kindergarten_participation_against_high_school_graduation(district)
  end

  def kindergarten_participation_correlates_with_high_school_graduation(district)
    kindergarten_graduation_analysis.kindergarten_participation_correlates_with_high_school_graduation(district)
  end
end
