#coding:utf-8
require 'nokogiri'
require 'open-uri'
require 'natto'
require 'rexml/document'
require 'open-uri'
require 'uri'

$wordHash = {}
$categoryHash = {}
$interestVector = {}
$score = {}
$urlArray1 = []
$urlArray2 = []
naiseki = 0


$urlArray1 = ["http://blog.gogotanaka.me/entry/2014/07/03/free_fee_is_more_than_600000", "http://liskul.com/wm_bpsychology28-3342", "http://qiita.com/oggata/items/5de43d71692d1abcff7c"]

$urlArray2 = ["http://ja.wikipedia.org/wiki/%E4%BA%BA%E6%96%87%E7%A7%91%E5%AD%A6", "http://ja.wikipedia.org/wiki/%E7%A4%BE%E4%BC%9A%E7%A7%91%E5%AD%A6", "http://ja.wikipedia.org/wiki/%E8%87%AA%E7%84%B6%E7%A7%91%E5%AD%A6"]

def category(word)

	url = "http://ja.wikipedia.org/w/api.php?format=xml&action=query&prop=categories&titles=" + word
	url_escape = URI.escape(url)
	doc = REXML::Document.new(open(url_escape))

	doc.elements.each('api/query/pages/page/categories/cl') do |element|
  		
  			c = element.attributes["title"]
  			$categoryHash[c] ? $categoryHash[c] += 1 : $categoryHash[c] = 1
 		
	end

end


def sum(h)
	sum_value = 0
	h.each_value do |v|
		 sum_value += v
	end
	return sum_value
end

#内積計算
def inner_product(hash1,hash2)

	hash1.each do |key1, value1|
		hash2.each do |key2, value2| 

			if key1 == key2
				naiseki += hash1[key1] * hash2[key2]
				
			end
			
		end

	end

	return naiseki

end



$nm = Natto::MeCab.new


#urlArrayからwordHash抽出
def wh(uA)
	uA.each do |url|

		doc = Nokogiri::HTML(open(url)) do |config|
  			config.noblanks
		end

		doc.search("script").each do |script|
  			script.content = "" ##scriptタグの中身を空にする
		end

		doc.css('body').each do |elm|
  			text = elm.content.gsub(/(\t|\s|\n|\r|\f|\v)/,"")
  			$nm.parse(text) do |n|
   			 	$wordHash[n.surface] ? $wordHash[n.surface] += 1 : $wordHash[n.surface] = 1 if n.feature.match("名詞")
  			end
		end
		return $wordHash
	end

end

#wordHash→categoryHash→interestVector
def ch(w)

	w.each do |key, value|
		category(key)
	end


	s = sum($categoryHash).to_f

	$categoryHash.each do |key, value|
		value_percent = (value/s) * 10000
		#puts "#{key} => #{value_percent} \n"
		$interestVector[key] = value_percent
	end
	return $interestVector

end

$wH1 = wh($urlArray1)
$iV1 = ch($wH1)

$urlArray2.each do |u|


	$wH2 = wh(u)
	
	$iV2 = ch($wH2)

	$score[u] = inner_product($iV1,$iV2)

	#puts "#{u} => score:#{$score}"

end

puts $score.sort {|(k1, v1), (k2, v2)| v2 <=> v1 }



