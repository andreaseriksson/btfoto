namespace :one_offs do
  desc "Set all as printed"
  task set_orders_as_printed: :environment do
    Order.unprinted.update_all(printed_at: Time.now)
  end
end