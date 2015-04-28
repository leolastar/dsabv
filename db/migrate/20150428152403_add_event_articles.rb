class AddEventArticles < ActiveRecord::Migration
  def change
  	Article.create(text: "Check edit to edit this text here. Events" )
  	Article.create(text: "Check edit to edit this text here. Buddy Walk" )
  	Article.create(text: "Check edit to edit this text here. DS Class" )
  end
end
