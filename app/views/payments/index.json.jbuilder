json.array!(@payments) do |payment|
  json.extract! payment, :id, :token, :payer_id, :amount
  json.url payment_url(payment, format: :json)
end
