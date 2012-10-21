require 'spec_helper'

class TooManyValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    #puts "validate called"
    if value.size > 4
      #puts "too many???"
      record.errors[attribute] << 'too many'
    end
  end
end    
    
class Task
  include Mongoid::Document
    
  has_many :parts, inverse_of: :task, autosave: true
  validates :parts, too_many: true
end
    
class Part
  include Mongoid::Document
    
  belongs_to :task, inverse_of: :parts
end

describe Task do 
  it "should not have too many parts" do    
    task = Task.create!
             
    #puts "ADDING PARTS"
    3.times { task.parts.build }
    task.save
              
    #puts "task.errors['parts'] = #{task.errors["parts"]}"
              
    #Task.find(task._id).parts.size.should == 4
  end
end