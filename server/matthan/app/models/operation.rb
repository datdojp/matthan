class Operation
  include Mongoid::Document
  include Mongoid::Timestamps

  ENGINE_STATUS_ON = 1
  ENGINE_STATUS_OFF = 0

  field :seat_positions, type: String
  field :time, type: Time
  field :engine_status, type: Integer
  field :speed, type: Float
  field :transaction_id, type: String
  
  belongs_to :car
end