json.array!(@groups) do |group|
  json.extract! group, :id, :id, :active, :first, :last, :name
  json.url group_url(group, format: :json)
end
