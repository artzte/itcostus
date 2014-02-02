namespace :budget do
  desc "import transactions: FILE=<filename> ACCOUNT=visa|checking"
  task :import => [:environment] do
    account = ENV['ACCOUNT']
    file = ENV['FILE']

    Transaction.import file, account
    Transaction.run_matchers true
  end

  desc "export monthly summaries"
  task :export => [:environment] do
    table = {}

    categories = Category.budgetary

    categories.each do |category|
      summaries = category.month_summaries
      summaries.each do |summary|
        table[summary[0]] ||= {}
        table[summary[0]][category.name] = summary[1].to_s
      end
    end

    months = Transaction
      .group("year(transactions.posted_at), month(transactions.posted_at)")
      .select("date_format(t.posted_at, '%Y-%m') AS month")
      .order("month")

    CSV.open(Rails.root.join("summary.csv"), "w") do |csv|
      csv << ["Date"] + categories.order('name').collect(&:name)
      table.keys.sort.each do |month|
        csv << [month] + categories.order('name').collect(&:name).collect do |name|
          table[month][name]||""
        end
      end
    end
  end

end
