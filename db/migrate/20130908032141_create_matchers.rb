class CreateMatchers < ActiveRecord::Migration
  def change
    create_table :matchers do |t|
      t.string :words
      t.references :category
      t.timestamps
    end

    CategoryMatcher.all.each do |cm|
      matchers = cm.regex.split('|')
      category = Category.find_by_name cm.category
      raise Error.new(cm.category) unless category
      matchers.each do |matcher|
        words = matcher.split.reject{|word| word.blank?}.collect(&:downcase).uniq
        next if words.empty?
        Matcher.create words: words.join(' '), category: category
      end
    end
  end
end
