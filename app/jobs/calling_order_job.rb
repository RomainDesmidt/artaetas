class CallingOrderJob < ApplicationJob
  include SuckerPunch::Job
  queue_as :default

  def perform(id_order)
    puts id_order
    puts id_order.is_a? Integer
    ActiveRecord::Base.connection_pool.with_connection do
      Order.where(state: "pending").each do |order|
          puts order.checkout_session_id
          sleep 4
      end
    end
  end
end
