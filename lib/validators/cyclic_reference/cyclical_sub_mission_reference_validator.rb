class CyclicalSubMissionReferenceValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    if cycle_created?(object)
      object.errors[attribute] << (options[:message] || "is not formatted properly") 
    end
  end
  
private
  def cycle_created?(record)
    cycle_detected?(record, record.title, Set.new([record.title]))
  end
  
  def cycle_detected?(record, cycle_node, visited_set)
    record.mission_embeddings.each do |sub_embedding|
      sub_record = sub_embedding.sub_mission
      if (sub_record.title == cycle_node) then return true end
      if !visited_set.include?(sub_record.title)
        visited_set << sub_record.title
        if cycle_detected?(sub_record, cycle_node, visited_set) then return true end
      end
    end
    return false
  end
end
