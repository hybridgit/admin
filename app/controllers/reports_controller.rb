class ReportsController < ApplicationController
  def total_phone_numbers
    @total_phone_numbers = CabRequest.total_phone_numbers(params[:start_date], params[:end_date])

    respond_to do |format|
			format.html
			format.json { render :json => @total_phone_numbers }
		end
  end

  def total_sms_sent
    @total_sms_sent = CabRequest.total_sms_sent(params[:start_date], params[:end_date])

    respond_to do |format|
			format.html
			format.json { render :json => @total_sms_sent }
		end
  end

  def average_sms_per_person
  end

  def successful_connections
  end

  def connected_customers
  end
end
