namespace :budget do
  desc "import transactions: FILE=<filename> ACCOUNT=visa|checking"
  task :import => [:environment] do
    account = ENV['ACCOUNT']
    file = ENV['FILE']

    Transaction.import file, account
    Transaction.run_matchers true
  end

end
