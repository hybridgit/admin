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

end
