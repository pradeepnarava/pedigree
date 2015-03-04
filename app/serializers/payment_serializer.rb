class PaymentSerializer < ActiveModel::Serializer
  attributes :id, :token, :payer_id, :amount
end
