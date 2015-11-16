module KeywordParser
  def self.key_parser(district)
    if district.class == String
      district
    elsif district.has_key?(:for)
      district = district.delete(:for)
    elsif district.has_key?(:against)
      district = district.delete(:against)
    elsif district.has_key?(:across)
      district = district.delete(:across)
    end
  end
end 