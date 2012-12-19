require 'spec_helper'

describe UserConnection do 
  it "should create UserConnection" do
    user_connection = UserConnection.new
    create(:user).user_connections << user_connection
    user_connection.connection = create(:user)
    
    lambda {user_connection.save!}.should_not raise_error
  end

  describe "relations" do
    it "should relate to connection properly" do
      user_connection = UserConnection.new
      connector = create(:user)
      connection = create(:user)
      connector.user_connections << user_connection
      user_connection.connection = connection

      connector.user_connections.first.connection.should == connection
      connection.inverse_user_connections.first.user.should == connector
    end
  end
  
  describe "validations" do
    it "should have a connection" do
      user_connection = UserConnection.new
      create(:user).user_connections << user_connection
    
      lambda {user_connection.save!}.should raise_error
    end
  end
end