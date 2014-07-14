testhash1 = {"red" => 1, "blue" => 5, "green" => 5}
testhash2 = {"red" => 1, "blue" => 3, "green" => 6}

def inner_product(hash1, hash2)
  naiseki = 0

  hash1.keys.each do |k|
    next unless hash1.has_key? k and hash2.has_key? k
    naiseki += hash1[k] * hash2[k]
  end

  return naiseki
end


puts inner_product(testhash1, testhash2)
