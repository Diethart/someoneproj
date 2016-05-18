# This file should contain all the record creation needed to seed the database
# with its default values.
# The data can then be loaded with the rake db:seed
# (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#require 'nokogiri'
#require 'open-uri'

require 'open-uri'
url = "http://www.languagedaily.com/learn-german/vocabulary/common-german-words"

page = Nokogiri::HTML(open(url))

words = Hash[page.css('td.bigLetter').map { |original_word| original_word.content }.zip(page.css('td.bigLetter + td').map { |translated_word| translated_word.content })]
test_user = User.create( email: "diethart19@gmail.com", password: "admin", password_confirmation: "admin" )
test_block = Block.create( title: "testdeck", user_id: test_user.id )
words.each_pair do |original, translated|
  Card.create(original_text: original, translated_text: translated, user_id: test_user.id, block_id: test_block.id)
end
