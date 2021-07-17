class User
  include Mongoid::Document

  field :username, type: String
  field :arena, type: String
  field :rating, type: Integer
end
