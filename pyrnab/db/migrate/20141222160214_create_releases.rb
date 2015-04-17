class CreateReleases < ActiveRecord::Migration
  def change
    return
    create_table :releases do |t|
      t.integer :id
      t.datetime :added
      t.datetime :posted
      t.string :name
      t.string :search_name
      t.string :posted_by
      t.integer :status
      t.integer :grabs
      t.integer :size
      t.string :passworded
      t.boolean :unwanted
      t.integer :group_id
      t.integer :category_id
      t.integer :regex_id
      t.integer :tvshow_id
      t.integer :tvshow_metablack_id
      t.integer :movie_id
      t.integer :movie_metablack_id
      t.integer :nzb_id
      t.integer :rar_metablack_id
      t.integer :nfo_id
      t.integer :nfo_metablack_id
      t.integer :sfv_id
      t.integer :sfv_metablack_id
      t.integer :episode_id

      t.timestamps
    end
  end
end
