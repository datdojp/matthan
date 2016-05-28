class Driver
  include Mongoid:Document
  include Mongoid:Timestamps

  field :name, type: String
  field :phone, type: String
  field :address, type: String

  belongs_to :owner
  belongs_to :car

end