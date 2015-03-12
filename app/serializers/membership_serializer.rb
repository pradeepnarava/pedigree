class MembershipSerializer < ActiveModel::Serializer
  attributes :id, :type, :fee_amount
end
