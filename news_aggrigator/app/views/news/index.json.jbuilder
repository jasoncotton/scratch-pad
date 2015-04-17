json.array!(@news) do |news|
  json.extract! news, :title, :url, :source
end
