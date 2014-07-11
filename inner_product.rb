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