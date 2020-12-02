namespace :utilities do

  # TODO: Delete theses. They are all examples that function on another application.
  # task :set_ice_cube_schedules => :environment do
  #   AvailableTime.all.each do |available_time|
  #     available_time.set_ice_cube_schedule
  #     available_time.save!
  #   end
  # end
  #
  # task :add_schedule_to_available_times => :environment do
  #   AvailableTime.all.each do |available_time|
  #     if available_time.schedule
  #       puts "#{available_time.id} Has schedule"
  #     else
  #       available_time.schedule = IceCube::Schedule.new
  #       available_time.schedule.add_recurrence_rule(IceCube::Rule.weekly(1).day(available_time.week_day))
  #       available_time.save!
  #       puts "Added schedule rules to #{available_time.id}"
  #     end
  #   end
  # end
  #
  # task :remove_all_invalid_available_times => :environment do
  #   times_removed = 0
  #   AvailableTime.all.each do |time|
  #     if time.time_block == 8
  #       time.destroy!
  #       times_removed += 1
  #     end
  #   end
  #   puts "#{times_removed} invalid times removed."
  # end
  #
  #
  # task :clean_phone_numbers => :environment do
  #   User.all.each do |user|
  #     if user.phone.present?
  #       clean_number = user.phone.delete("^0-9")
  #       if clean_number.length > 10 and clean_number.first == '1'
  #         clean_number = clean_number.last(10)
  #       end
  #       user.phone = clean_number
  #       user.save!
  #       puts "Phone number for u_#{user.id} updated."
  #     end
  #   end
  # end
  #
  # task :update_stripe_phone_numbers => :environment do
  #   Coordinator.where.not(stripe_id: nil).each do |user|
  #     if user.phone.present? && user.stripe_id.present?
  #       customer = Stripe::Customer.retrieve(user.stripe_id) rescue next
  #       shipping_data = {}
  #       shipping_data[:address] = {
  #         line1: "24201 West Valencia Blvd",
  #         city: "Santa Clarita",
  #         state: "CA",
  #         postal_code: "91355",
  #       }
  #       shipping_data[:name] = user.full_name
  #       shipping_data[:phone] = user.phone
  #       customer.shipping = shipping_data
  #       customer.metadata = { 'user_id': user.id }
  #       customer.save
  #     end
  #   end
  # end
  #
  #
  # task :clean_notifications_with_no_sessions => :environment do
  #   Notification.all.each do |notification|
  #     if  TutoringSession.where(:id => notification.tutoring_session_id).count == 0
  #       Notification.find(notification.id).destroy
  #     else
  #     end
  #   end
  # end
  #
  #
  # task :cancel_unconfirmed_sessions => :environment do
  #   TutoringSession.cancel_pending_scheduled_within_hour
  # end
  #
  # desc "Removes the accounts and data created by scammers"
  # task :remove_accounts_and_data, [:account_ids] => :environment do |task, args|
  #   removed__data_logger = ::Logger.new(Rails.root.join('log', 'removed_data.log'))
  #
  #   account_ids = args[:account_ids].split(' ')
  #   account_ids.each do |id|
  #     account = User.find_by_id(id)
  #     if account and account.type == "Coordinator"
  #       removed__data_logger.info "#{"="*10}"
  #       removed__data_logger.info "Account ID: #{account.id}"
  #       removed__data_logger.info "Account email: #{account.email}"
  #       removed__data_logger.info "Account phone: #{account.phone}"
  #       removed__data_logger.info "Account zip: #{account.zip}"
  #       removed__data_logger.info "Account f_name: #{account.f_name}"
  #       removed__data_logger.info "Account created_at: #{account.created_at}"
  #       account.destroy
  #       puts "Account with id #{id} and data removed"
  #     elsif account and account.type != "Coordinator"
  #       puts "Account with id #{id} wasn't removed. Rake task only deletes account with type Coordinator"
  #     else
  #       puts "Account with id: #{id} does not exist"
  #     end
  #   end
  # end
  #
  # desc "Destroy Coordinator or Tutor user accounts"
  # task :destroy_coordinator_or_tutor_user_account, [:user_id] => :environment do |task, args|
  #   user = User.find_by_id(args[:user_id])
  #   unless user
  #     abort "User not found. Unable to delete. Please check that you passed the User ID as the argument to the rake task."
  #   end
  #
  #   # Only Coordinator and Tutor accounts responds to tutoring_sessions method
  #   unless user.respond_to?(:tutoring_sessions)
  #     abort "User can't be deleted. This rake task is only able to delete/destroy coordinator or tutor user accounts."
  #   end
  #
  #   if user.tutoring_sessions.any?
  #     abort "User can't be deleted because they have tutoring sessions."
  #   end
  #
  #   if user.destroy
  #     puts "Account ID: #{user.id}"
  #     puts "Account email: #{user.email}"
  #     puts "Account phone: #{user.phone}"
  #     puts "Account zip: #{user.zip}"
  #     puts "Account f_name: #{user.f_name}"
  #     puts "Account created_at: #{user.created_at}"
  #     puts "User with id##{user.id} has been removed from the database."
  #   else
  #     puts "Something went wrong. We were unable to delete the user from the database."
  #   end
  # end
  #
  # desc "Update all approved tutors average response time"
  # task :update_approved_tutors_average_response_time => :environment do
  #   Tutor.where(u_status: 'Application Approved').each do |tutor|
  #     Tutors::StatsService.new(tutor).update_average_response_time
  #   end
  # end
  #
  # desc "Grouping all duplicate search logs/leads within last 7 days"
  # task :group_duplicate_within_last_7_days => :environment do
  #   recent_leads = SearchLog.where("created_at >= ?", Time.now - 7.days).order("created_at DESC")
  #
  #   lead_groups = recent_leads.group_by {|l| [l.subject, l.location, l.user_id] }
  #
  #   lead_groups.each do |attrs, items|
  #     next unless items.count > 1
  #     latest_item = items.shift
  #     latest_item.times = items.count
  #     latest_item.save
  #     items.map(&:destroy)
  #   end
  # end
  #
  # desc "Remove all invalid - promocode is missing - unapplied redemptions"
  # task :remove_all_invalid_unapplied_redemptions => :environment do
  #   promocode_is_missing = ->(code) { !Promo.find_by_code(code) }
  #   times_removed = 0
  #   Redemption.where(invoice_id: nil).select {|r| promocode_is_missing.call(r.code) }.each do |redemption|
  #     redemption.destroy!
  #     times_removed += 1
  #   end
  #   puts "#{times_removed} invalid redemptions removed."
  # end
  #
  # desc "Updates and requests capabilities for existing stripe accounts"
  # task :update_and_request_capabilities_for_stripe_accounts => :environment do
  #   tutor_ids = [82,192,255,346,376,636,762,837,1055,1101,2029,2546,2726,2991,3158,3326,3505,3781,3812,4001,4193,4474,4524,4623,4970,5117]
  #   Tutor.where(id: tutor_ids).find_each do |tutor|
  #     begin
  #       Stripe::Account.update(
  #         tutor.stripe_id,
  #         {business_profile: {url: "https://www.whiztutorapp.com"}},
  #       )
  #
  #       Stripe::Account.update_capability(
  #         tutor.stripe_id,
  #         'transfers',
  #         {requested: true},
  #       )
  #
  #       Stripe::Account.update_capability(
  #         tutor.stripe_id,
  #         'card_payments',
  #         {requested: true},
  #       )
  #     rescue => e
  #       puts "Something went wrong with tutor with ID #{tutor.id}"
  #     end
  #   end
  #   puts "Transfers and card_payments capabilities successfully requested for existing Stripe accounts"
  # end
  #
  #

end
