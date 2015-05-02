class AddInitialArticles < ActiveRecord::Migration
  def change
  	Article.create(text: "Check edit to edit this text here." )
	Article.create(text: "Check edit to edit this text here too. You can use HTML." )
  end
end
