class PaymentGateway
  NEW = 'new'.freeze
  PENDING = 'pending'.freeze
  COMPLETED = 'completed'.freeze
  FAILED = 'failed'.freeze

  TransactionApi = SquareConnect::TransactionApi.new()
  LocationApi = SquareConnect::LocationApi.new()
  Locations = LocationApi.list_locations(ENV['square_access_token'])

  def self.charge(card_nounce, amount, currency)
    payment = self.new(card_nounce, amount, currency)
    payment.charge_payment!
    payment
  end

  attr_reader :payload, :status, :errors

  def initialize(card_nounce, amount, currency)
    @retry = 0
    @status = NEW
    @payload = {
      card_nonce: card_nounce,
      amount_money: {
        amount: amount,
        currency: currency
      },
      idempotency_key: SecureRandom.uuid
    }
  end

  def charge_payment!
    self.status = PENDING
    resp = TransactionApi.charge(ENV['square_access_token'], Locations.locations[0].id, payload)
    self.status = COMPLETED
  rescue SquareConnect::ApiError => e
    # TODO: should only retry when timeout
    retry if @retry < 3
    @retry += 1

    self.status = FAILED
    Rollbar.error('Error encountered while charging card', error: e)
    
    self.errors = JSON.parse(e.response_body)["errors"]
  end
end