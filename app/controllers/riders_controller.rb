class RidersController < ApplicationController
  layout "map", only: [:map]

  before_filter :authenticate
  before_filter do |c|
    c.send(:authorize, self.controller_name, self.action_name)
  end

  def stats
  end

  def map
  end

  def map_data
  end

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

  def successful_connections
  end

  def map_total_phone_numbers
    @page_size = params[:page_size] == "All" ?  params[:page_size] : Integer(params[:page_size])
    @page = Integer(params[:page])
    @total_phone_numbers = @page_size == "All" ?
                                    CabRequest.map_total_phone_numbers(params[:start_date], params[:end_date]) :
                                    CabRequest.map_total_phone_numbers(params[:start_date], params[:end_date])
                                     .paginate(page: @page, per_page: @page_size)
    @total_sms_sent = @page_size == "All" ?
                               CabRequest.map_total_sms_sent(params[:start_date], params[:end_date]) :
                               CabRequest.map_total_sms_sent(params[:start_date], params[:end_date])
                                         .paginate(page: @page, per_page: @page_size)
    @total = CabRequest.map_total_phone_numbers_count(params[:start_date], params[:end_date])

    @response = {
      data: @total_phone_numbers,
      total_phone_numbers: @total_phone_numbers,
      total_sms_sent: @total_sms_sent,
      successful_connections: [],
      page: @page,
      page_size: @page_size,
      total_page_size: @page_size == "All" ? 1 : (@total.to_f/@page_size).ceil
    }

    respond_to do |format|
      format.html
      format.json { render :json => @response }
    end
  end

  def map_total_sms_sent
    @page_size = params[:page_size] == "All" ?  params[:page_size] : Integer(params[:page_size])
    @page = Integer(params[:page])
    @total_phone_numbers = @page_size == "All" ?
                                    CabRequest.map_total_phone_numbers(params[:start_date], params[:end_date]) :
                                    CabRequest.map_total_phone_numbers(params[:start_date], params[:end_date])
                                     .paginate(page: @page, per_page: @page_size)
    @total_sms_sent = @page_size == "All" ?
                               CabRequest.map_total_sms_sent(params[:start_date], params[:end_date]) :
                               CabRequest.map_total_sms_sent(params[:start_date], params[:end_date])
                                         .paginate(page: @page, per_page: @page_size)
    @total = CabRequest.map_total_sms_sent_count(params[:start_date], params[:end_date])

    @response = {
      data: @total_sms_sent,
      total_phone_numbers: @total_phone_numbers,
      total_sms_sent: @total_sms_sent,
      successful_connections: [],
      page: @page,
      page_size: @page_size,
      total_page_size: @page_size == "All" ? 1 : (@total.to_f/@page_size).ceil
    }

    respond_to do |format|
      format.html
      format.json { render :json => @response }
    end
  end

  def map_successful_connections
  end
end
