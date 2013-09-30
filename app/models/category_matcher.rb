class CategoryMatcher < ActiveRecord::Base

  def regexp
    @regexp ||= Regexp.new self.value, Regexp::IGNORECASE
    @regexp
  end

  def keywords
    @keywords ||= self.value.split.uniq
    @keywords
  end

  def self.dump
    dumped = all
    puts "["
    dumped.each{|cm| puts "  [\"#{cm.category}\",\"#{cm.regex}\"], "}
    puts "]"
  end

end