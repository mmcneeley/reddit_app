class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :url
      t.text :content
      t.text :image_url
      t.string :link_title
      t.references :user, foreign_key: true
      t.references :topic, foreign_key: true
      t.timestamps
    end
  end
end
