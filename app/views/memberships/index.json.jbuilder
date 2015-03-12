json.array!(@memberships) do |membership|
  json.extract! membership, :id, :type, :fee_amount
  json.url membership_url(membership, format: :json)
end
