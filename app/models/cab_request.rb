class CabRequest < ActiveRecord::Base
  belongs_to :driver_list

  def self.total_phone_numbers(start_date, end_date)
    self.select("date(created_at) as date, count(current_cell_no) as value")
        .where("created_at >= :start_date AND created_at <= :end_date",
                {start_date: start_date, end_date: end_date})
        .group("date(created_at)")
        .order(created_at: :asc)
  end

  def self.total_sms_sent(start_date, end_date)
    self.select("date(created_at) as date, count(current_cell_no) as value")
        .where("created_at >= :start_date AND created_at <= :end_date",
                {start_date: start_date, end_date: end_date})
        .group("date(created_at)")
        .order(created_at: :asc)
  end

end
