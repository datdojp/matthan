class Owner
  include Mongoid::Document
  include Mongoid::Timestamps

  ROLE_OWNER = 0
  ROLE_MASTER_OWNER = 1

  field :name, type: String
  field :email, type: String
  field :password, type: String
  field :phone, type: String
  field :address, type: String
  field :role, type: Integer

  has_many :cars
  has_many :drivers

end