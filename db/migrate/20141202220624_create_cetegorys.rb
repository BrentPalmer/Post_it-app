class CreateCetegorys < ActiveRecord::Migration
  def change
    create_table :cetegorys do |t|
      t.string :name
    end
  end
end
