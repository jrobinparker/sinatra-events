class Event < ActiveRecord::Base
  validates_presence_of :name, :start_date, :start_time, :end_date, :end_time, :description

  belongs_to :user

end
