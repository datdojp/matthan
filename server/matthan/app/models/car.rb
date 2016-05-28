class Car
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :license_plate, type: String
  field :type, type: String
  field :sim_number, type: String

  belongs_to :owner
  has_one :driver
  has_many :operations

end