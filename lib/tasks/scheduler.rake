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
    result = searcher.search(keyword.keyword, 1, keyword.genre)
    count = result["count"].to_i
    if count == keyword.item_count
      puts "no change"
      next
    end
    if user.enable_email_notify
      puts "send mail..."
      NotificationMailer.notify_result_update(user, keyword.keyword, keyword.item_count, count).deliver
    end
    if user.enable_fcm_notify
      # TODO: FCM Notify
      # puts "send fcm..."
    end
    puts "update database..."
    keyword.item_count = result["count"]
    keyword.save
  end
end

task :test_mail => :environment do
  puts "get user..."
  user = User.find(1)
  puts "send mail..."
  NotificationMailer.notify_result_update(user, "test", 1, 2).deliver
end
