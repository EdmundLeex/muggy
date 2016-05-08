class OrdersController < ApplicationController
  def create
    user = User.find_or_create_by(email: user_params[:email])
    user.update!(user_params)

    order = user.orders.new(order_params)
    if order.save
    else
    end

    # The SDK throws an exception if a Connect endpoint responds with anything besides 200 (success).
    # This block catches any exceptions that occur from the request.
    locationApi = SquareConnect::LocationApi.new()
    locations = locationApi.list_locations(Rails.application.secrets.square_access_token)
    begin
      resp = transaction_api.charge(Rails.application.secrets.square_access_token, locations.locations[0].id, request_body)
    rescue SquareConnect::ApiError => e
      puts 'Error encountered while charging card:'
      puts e.message
      render json: {:status => 400, :errors => JSON.parse(e.response_body)["errors"]  }
      return
    end
    puts resp
    
    data = {
      amount: amount, 
      user: {
        name: params[:name], 
        street_address_1: params[:street_address_1], 
        street_address_2: params[:street_address_2], 
        state: params[:state],
        zip: params[:zip],
        city: params[:city]  
      },
      card: resp.transaction.tenders[0].card_details.card
    }

    # send receipt email to user
    ReceiptMailer.charge_email(params[:email],data).deliver_now if Rails.env == "development"
    
    render json: {:status => 200}
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end

  def order_params
    params.require(:order).permit(:street_address, :street_address_2, :city, :state, :zipcode, :country, :phone_number)
  end
end
