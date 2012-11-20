module CustomMatchers
    
  class BeTheSameHtmlAs
    def initialize(expected)
      @expected = expected
    end

    def matches?(target)
      @target = target
      remove_newlines(@target).eql?(remove_newlines(@expected))
    end

    def failure_message
      "expected:\n <#{@target.to_s}> to " +
      "the same html as:\n <#{@expected.to_s}>"
    end

    def negative_failure_message
      "expected:\n <#{@target.to_s}> not to " +
      "be the same html as:\n <#{@expected.to_s}>"
    end
    
  private
    def remove_newlines(string)
      string.gsub(/\n\s*/, "") 
    end
  
  end

  # Actual matcher that is exposed.
  def be_the_same_html_as(expected)
    BeTheSameHtmlAs.new(expected)
  end
end