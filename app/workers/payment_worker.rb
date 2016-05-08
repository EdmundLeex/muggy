class PaymentWorker
  include Sidekiq::Worker
  def perform(card_nounce, amount, currency = 'USD')
    PaymentGateway.charge(card_nounce, amount, currency)
  end
end