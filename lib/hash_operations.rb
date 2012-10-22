class HashOperations
  def self.multiply_hash_by_value(hash, multiplier)
    hash.inject({}) do |agg_hash, (key, value)|
      agg_hash[key] = value * multiplier
      agg_hash
    end
  end
  
  def self.add_hashes(hash_1, hash_2)
    hash_1.merge(hash_2) do |key, value_1, value_2|
      value_1 + value_2
    end
  end
end