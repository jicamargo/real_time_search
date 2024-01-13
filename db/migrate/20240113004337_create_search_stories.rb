class CreateSearchStories < ActiveRecord::Migration[7.1]
  def change
    create_table :search_stories do |t|
      t.string :query
      t.string :ip_address
      t.string :user

      t.timestamps
    end
  end
end
