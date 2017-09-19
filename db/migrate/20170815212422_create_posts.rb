class CreatePosts < ActiveRecord::Migration[5.1]
  def change
  	create_table :posts do |t|
  		t.string :text, limit: 150
      t.string :content
  		t.belongs_to :user

  	end
  end
end
