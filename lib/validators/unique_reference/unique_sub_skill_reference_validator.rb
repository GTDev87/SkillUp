class UniqueSubSkillReferenceValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    if !all_unique?(value)
      object.errors[attribute] << (options[:message] || "is not formatted properly") 
    end
  end
  
private
  def all_unique?(referenced_documents)
    sub_document_titles = referenced_documents.map do |sub_embedded| 
      sub_embedded.sub_skill.title 
    end
    
    sub_document_titles.uniq.size == referenced_documents.size
  end
end
