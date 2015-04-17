json.array!(@releases) do |release|
  json.extract! release, :id, :id, :added, :posted, :name, :search_name, :posted_by, :status, :grabs, :size, :passworded, :unwanted, :group_id, :category_id, :regex_id, :tvshow_id, :tvshow_metablack_id, :movie_id, :movie_metablack_id, :nzb_id, :rar_metablack_id, :nfo_id, :nfo_metablack_id, :sfv_id, :sfv_metablack_id, :episode_id
  json.url release_url(release, format: :json)
end
