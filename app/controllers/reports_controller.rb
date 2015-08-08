class ReportsController < ApplicationController
  def total_phone_numbers
    @total_phone_numbers_count = CabRequest.total_phone_numbers_count(params[:start_date], params[:end_date])
    @total_sms_sent_count = CabRequest.total_sms_sent_count(params[:start_date], params[:end_date])
    @average_sms_per_person = @total_phone_numbers_count > 0 ? (@total_sms_sent_count.to_f / @total_phone_numbers_count).round(2) : 0;

    @response = {
      "data" => CabRequest.total_phone_numbers(params[:start_date], params[:end_date]),
      "total_phone_numbers_count" => @total_phone_numbers_count,
      "total_sms_sent_count" => @total_sms_sent_count,
      "average_sms_per_person" => @average_sms_per_person,
      "successful_connections_count" => 0
    }

    respond_to do |format|
			format.html
			format.json { render :json => @response }
		end
  end

  def total_sms_sent
    @total_phone_numbers_count = CabRequest.total_phone_numbers_count(params[:start_date], params[:end_date])
    @total_sms_sent_count = CabRequest.total_sms_sent_count(params[:start_date], params[:end_date])
    @average_sms_per_person = @total_phone_numbers_count > 0 ? (@total_sms_sent_count.to_f / @total_phone_numbers_count).round(2) : 0;

    @response = {
      "data" => CabRequest.total_sms_sent(params[:start_date], params[:end_date]),
      "total_phone_numbers_count" => @total_phone_numbers_count,
      "total_sms_sent_count" => @total_sms_sent_count,
      "average_sms_per_person" => @average_sms_per_person,
      "successful_connections_count" => 0
    }

    respond_to do |format|
			format.html
			format.json { render :json => @response }
		end
  end

  def average_sms_per_person
  end

  def successful_connections
  end

  def connected_customers
  end
end
