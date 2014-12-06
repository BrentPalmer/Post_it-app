class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :url, :title
      t.text :description
    end
  end
end
