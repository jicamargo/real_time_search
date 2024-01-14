class AddCounterToSearchStories < ActiveRecord::Migration[7.1]
  def change
    add_column :search_stories, :counter, :integer, default: 1
    add_index :search_stories, [:ip_address, :user_name, :query], unique: true
  end
end
