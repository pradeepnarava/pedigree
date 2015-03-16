json.array!(@user_relations) do |user_relation|
  json.extract! user_relation, :id, :name, :sex, :user_id
  json.url user_relation_url(user_relation, format: :json)
end
