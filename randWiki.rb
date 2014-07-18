require 'rexml/document'
require 'open-uri'
require 'uri'

$urlArray2 = []

url = "http://ja.wikipedia.org/w/api.php?format=xml&action=query&list=random&rnnamespace=0&rnlimit=10"
doc = REXML::Document.new(open(url))
doc.elements.each('api/query/random/page/') do |element|
  		
  			c = element.attributes["title"]
  			$urlArray2.push("http://ja.wikipedia.org/wiki/#{c}")


 		
end

$urlArray2.each do |u|
	puts u
end

