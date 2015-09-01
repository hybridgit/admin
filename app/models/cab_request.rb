class CabRequest < ActiveRecord::Base
  belongs_to :driver

  def self.total_phone_numbers(start_date, end_date)
    self.select("date(created_at) as date, count(DISTINCT current_cell_no) as value")
        .where("created_at >= :start_date AND created_at <= :end_date",
                {start_date: start_date, end_date: end_date})
        .group("date(created_at)")
        .order(created_at: :asc)
  end

  def self.total_phone_numbers_count(start_date, end_date)
    self.select("DISTINCT current_cell_no")
        .where("created_at >= :start_date AND created_at <= :end_date",
                {start_date: start_date, end_date: end_date})
        .count
  end

  def self.total_sms_sent(start_date, end_date)
    self.select("date(created_at) as date, count(id) as value")
        .where("created_at >= :start_date AND created_at <= :end_date",
                {start_date: start_date, end_date: end_date})
        .group("date(created_at)")
        .order(created_at: :asc)
  end

  def self.total_sms_sent_count(start_date, end_date)
    self.where("created_at >= :start_date AND created_at <= :end_date",
                {start_date: start_date, end_date: end_date})
        .count
  end

  def self.map_total_phone_numbers(start_date, end_date)
    self.select("location, location_lat, location_long, count(DISTINCT current_cell_no) as value")
        .where("created_at >= :start_date AND created_at <= :end_date",
                {start_date: start_date, end_date: end_date})
        .group("location")
        .order("value DESC")
  end

  def self.map_total_phone_numbers_count(start_date, end_date)
    @numbers = self.select("location, location_lat, location_long, count(DISTINCT current_cell_no) as value")
                   .where("created_at >= :start_date AND created_at <= :end_date",
                          {start_date: start_date, end_date: end_date})
                   .group("location")
    @numbers.length
  end

  def self.map_total_sms_sent(start_date, end_date)
    self.select("location, location_lat, location_long, count(id) as value")
        .where("created_at >= :start_date AND created_at <= :end_date",
                {start_date: start_date, end_date: end_date})
        .group("location")
        .order("value DESC")
  end

  def self.map_total_sms_sent_count(start_date, end_date)
    @sms_sent = self.select("location, location_lat, location_long, count(id) as value")
                     .where("created_at >= :start_date AND created_at <= :end_date",
                            {start_date: start_date, end_date: end_date})
                     .group("location")
    @sms_sent.length
  end

  public
    def register_request(customer_cell_no, lat, long, location)
    	self.customer_cell_no    = customer_cell_no
    	self.location_lat            = lat
    	self.location_long           = long
    	self.location            = location
    	self.status              = false
    	self.broadcast           = false
      self.more_location_count = 0
      self.ordered             = false
      self.location_selected   = false
      self.offer_count         = 0
      self.broadcasted         = false
      self.deleted             = false
      self.closed              = false
    	self.save
    end

    def lock_choice(lat, long, location)
    	self.update_attributes(:location_lat => lat, :location_long => long, :location => location, :location_selected => true, :ordered => true)
    end

    def self.is_new(customer_cell_no)
      @cab_request = CabRequest.where(:deleted => false, :customer_cell_no => customer_cell_no)
      @old_request = @cab_request.where(:deleted => false, :status => false).last
      if @old_request.present?
        return false
      else
        return true
      end
    end

end
