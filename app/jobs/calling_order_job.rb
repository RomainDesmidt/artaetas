class CallingOrderJob < ApplicationJob
  include SuckerPunch::Job
  queue_as :default

  def perform
    Order.where(state: "pending").each do |order|
        puts order.checkout_session_id
        sleep 4
    end
  end
end
