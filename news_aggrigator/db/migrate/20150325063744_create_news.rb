class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :title
      t.string :url
      t.string :source
      t.integer :position

      t.timestamps
    end
  end
end
