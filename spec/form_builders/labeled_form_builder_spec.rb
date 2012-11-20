require 'spec_helper'

describe "LabeledFormBuilder", type: :helper do
  
  before(:each) do
    @user = create(:user)
    @username = @user.username
    @builder = LabeledFormBuilder.new(:user, @user, helper, {}, nil)
  end
  
  describe "formatting fields" do
    it "should format text_field" do
      @builder.text_field(:username).should be_the_same_html_as(
        "<div class=\"control-group\">
           <label class=\"control-label\" for=\"user_username\">Username</label>
           <div class=\"controls\">
             <input class=\"text_field\" id=\"user_username\" name=\"user[username]\" size=\"30\" type=\"text\" value=\"#{@username}\" />
           </div>
         </div>")
    end
    
    it "should format text_area" do
      @builder.text_area(:username).should be_the_same_html_as(
        "<div class=\"control-group\">
           <label class=\"control-label\" for=\"user_username\">Username</label>
           <div class=\"controls\">
             <textarea class=\"text_area\" cols=\"40\" id=\"user_username\" name=\"user[username]\" rows=\"20\">#{@username}</textarea>
           </div>
         </div>")
    end
    
    it "should format password_field" do
      @builder.password_field(:username).should be_the_same_html_as(
        "<div class=\"control-group\">
           <label class=\"control-label\" for=\"user_username\">Username</label>
           <div class=\"controls\">
             <input class=\"password_field\" id=\"user_username\" name=\"user[username]\" size=\"30\" type=\"password\" />
           </div>
         </div>")
    end
    
    it "should format error_messages" do
      user = build(:user)
      user.errors["foo"] = "bar"
      builder = LabeledFormBuilder.new(:user, user, helper, {}, nil)
      builder.error_messages.should be_the_same_html_as(
        "<div class=\"error_messages\">
          <h2>Invalid Fields</h2>
          <ul>
            <li>Foo bar</li>
          </ul>
         </div>")
    end
    
    it "should format submit" do
      @builder.submit.should be_the_same_html_as(
        "<div class=\"form-actions\">
          <input class=\"btn btn-primary\" name=\"commit\" type=\"submit\" value=\"Update User\" />
         </div>")
    end
    
    it "should format submit with label" do
      @builder.submit("Push Button").should be_the_same_html_as(
        "<div class=\"form-actions\">
          <input class=\"btn btn-primary\" name=\"commit\" type=\"submit\" value=\"Push Button\" />
         </div>")
    end
    
    it "should add hashes as options" do
      html = @builder.text_field(:username, {:class => 'extra_class', data: {nested_data: "nested_data" } } )
      html.should be_the_same_html_as(
        "<div class=\"control-group\">
           <label class=\"control-label\" for=\"user_username\">Username</label>
           <div class=\"controls\">
             <input class=\"extra_class text_field\" data-nested-data=\"nested_data\" id=\"user_username\" name=\"user[username]\" size=\"30\" type=\"text\" value=\"#{@username}\" />
           </div>
         </div>")
    end
    
    it "should add label as options" do
      html = @builder.text_field(:username, label: "My Name")
      html.should be_the_same_html_as(
        "<div class=\"control-group\">
           <label class=\"control-label\" for=\"user_username\">My Name</label>
           <div class=\"controls\">
             <input class=\"text_field\" id=\"user_username\" name=\"user[username]\" size=\"30\" type=\"text\" value=\"#{@username}\" />
           </div>
         </div>")
    end
  end
end