desc "This task is called by the Heroku scheduler add-on"
task :notify_books_result_update => :environment do
  puts "notify_books_result_update start.."
  puts "get keywords..."
  keywords = Keyword.all
  keywords.each do |keyword|
    puts "get user..."
    user = User.find(keyword.user_id)
    if !user.enable_email_notify && !user.enable_fcm_notify
      puts "not notify"
      next
    end
    puts "search books..."
    searcher = BookSearcher.new
    result = searcher.search(keyword.keyword, 1)
    if result["count"].to_i == keyword.item_count
      puts "no change"
      next
    end
    puts "update database..."
    keyword.item_count = result["count"]
    keyword.save
    if user.enable_email_notify
      # TODO: Email Notify
    end
    if user.enable_fcm_notify
      # TODO: FCM Notify
    end
  end
end