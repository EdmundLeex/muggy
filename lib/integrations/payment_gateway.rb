class PaymentGateway
  TransactionApi = SquareConnect::TransactionApi.new()
  LocationApi = SquareConnect::LocationApi.new()
  Locations = LocationApi.list_locations(ENV['square_access_token'])

  def self.charge(card_nounce, amount, currency = 'USD')
    payment = self.new(card_nounce, amount, currency)

    payment.charge_payment!
  end

  attr_reader :payload

  def initialize(card_nounce, amount, currency)
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
    resp = TransactionApi.charge(ENV['square_access_token'], Locations.locations[0].id, payload)

    # data = {
    #   amount: amount, 
    #   user: {
    #     name: params[:name], 
    #     street_address_1: params[:street_address_1], 
    #     street_address_2: params[:street_address_2], 
    #     state: params[:state],
    #     zip: params[:zip],
    #     city: params[:city]  
    #   },
    #   card: resp.transaction.tenders[0].card_details.card
    # }
    # ReceiptMailer.charge_email(params[:email],data).deliver_now if Rails.env == "development"
    
    return true
  rescue SquareConnect::ApiError => e
    Rollbar.error('Error encountered while charging card', error: e)
    
    return JSON.parse(e.response_body)["errors"]
  end
end