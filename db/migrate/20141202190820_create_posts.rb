class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.belongs_to :user_id
      t.string :url
      t.string :title
      t.text :description

    end
  end
end
