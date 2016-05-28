class Car
  include Mongoid::Document
  include Mongoid::Timestamps

  STATUS_NO_SIGNAL = 0
  STATUS_RUNNING = 1
  STATUS_OFF = 2
  STATUS_STOPPED = 3

  field :name, type: String
  field :license_plate, type: String
  field :type, type: String
  field :sim_number, type: String
  field :status, type: Integer

  belongs_to :owner
  has_one :driver
  has_many :operations

end