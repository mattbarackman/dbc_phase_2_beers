class CreateRecommendations < ActiveRecord::Migration
  def change
    create_table :recommendations do |t|
      t.references :user
      t.references :beer
      t.float :score  
    end
  end
end
