require 'nokogiri'
require 'open-uri'
require 'natto'
require 'rexml/document'
require 'open-uri'
require 'uri'


$urlArray1 = ["http://gigazine.net/news/20140714-memory-saving-devices/", "http://prs.is/zu89HkjK", "http://museum.ipsj.or.jp/pioneer/aiso.html", "http://jp.techcrunch.com/2014/07/12/20140711apple-opens-up-with-a-new-blog-about-swift-its-new-programming-language/", "http://t.co/fgFpjxK52p"]
$categoryHash = {}
def category(word)

	url = "http://ja.wikipedia.org/w/api.php?format=xml&action=query&prop=categories&titles=" + word
	url_escape = URI.escape(url)
	doc = REXML::Document.new(open(url_escape))

	doc.elements.each('api/query/pages/page/categories/cl') do |element|
  		
  			c = element.attributes["title"]
  			$categoryHash[c] ? $categoryHash[c] += 1 : $categoryHash[c] = 1
 		
	end

end

t0 = Time.now

$urlArray1.each do |key, value|
		category(key)
end

t1 = Time.now

puts "#{t1 - t0} 秒"