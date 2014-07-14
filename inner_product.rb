testhash1 = {"red" => 1, "blue" => 5, "green" => 5}
testhash2 = {"red" => 1, "blue" => 3, "green" => 6, "pink" => 9}
$naiseki = 0

def inner_product(hash1,hash2)
	

	hash1.each do |key1, value1|
		hash2.each do |key2, value2| 

			if key1 == key2
				$naiseki = $naiseki + hash1[key1] * hash2[key2]
				
			end
			
		end

	end

	return $naiseki

end


puts inner_product(testhash1,testhash2)