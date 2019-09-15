module Types
  class UserType < Types::BaseObject
    field :username, String, null: false
    field :email, String, null: false
    field :orders, [Types::OrderType], null: true
  end
end
