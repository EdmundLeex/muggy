class ProcessPaymentJob < ActiveJob::Base
  queue_as :default

  def perform(card_nounce, amount, currency = 'USD')
    PaymentGateway.charge(card_nounce, amount, currency)
  end
end
