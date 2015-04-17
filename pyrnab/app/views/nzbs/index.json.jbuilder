json.array!(@nzbs) do |nzb|
  json.extract! nzb, :id, :id, :data
  json.url nzb_url(nzb, format: :json)
end
