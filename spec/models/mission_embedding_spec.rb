require 'spec_helper'

describe MissionEmbedding do
  
  it "should create MissionEmbedding" do
    mission_embedding = MissionEmbedding.new(count: 1)
    
    mission_embedding.sub_mission = create(:mission)
    mission_embedding.super_mission = create(:mission)
    
    lambda {mission_embedding.save!}.should_not raise_error
  end
  
  describe "validations" do
    it "should require that MissionsEmbedding have count" do
      mission_embedding = MissionEmbedding.new
      
      mission_embedding.sub_mission = create(:mission)
      mission_embedding.super_mission = create(:mission)
    
      lambda {mission_embedding.save!}.should raise_error
    end
    
    it "should require that MissionsEmbedding have super_mission" do
      mission_embedding = MissionEmbedding.new(count: 1)
      
      mission_embedding.sub_mission = create(:mission)
    
      lambda {mission_embedding.save!}.should raise_error
    end
    
    it "should require that MissionsEmbedding have sub_mission" do
      mission_embedding = MissionEmbedding.new(count: 1)
      
      mission_embedding.super_mission = create(:mission)
    
      lambda {mission_embedding.save!}.should raise_error
    end
  end
  
  describe "relations" do
    describe Mission do
      it "should reference Mission" do
        mission_embedding = MissionEmbedding.new(count: 10)
        
        sub_mission = create(:mission, title: "Sub Mission Title")
        mission_embedding.sub_mission = sub_mission
        super_mission = create(:mission, title: "Super Mission Title")
        mission_embedding.super_mission = super_mission
        mission_embedding.save!
        
        MissionEmbedding.find(mission_embedding._id).sub_mission.title.should == "Sub Mission Title"
        MissionEmbedding.find(mission_embedding._id).super_mission.title.should == "Super Mission Title"
      end
      
      it "should be referenced by Mission" do
        mission_embedding = MissionEmbedding.new(count: 10)
        
        sub_mission = create(:mission, title: "Sub Mission Title")
        mission_embedding.sub_mission = sub_mission
        super_mission = create(:mission, title: "Super Mission Title")
        mission_embedding.super_mission = super_mission
        mission_embedding.save!
        
        Mission.find(sub_mission._id).super_embeddings.first.count.should == 10
        Mission.find(super_mission._id).mission_embeddings.first.count.should == 10
      end
    end
  end
  
  describe "fields" do
    it "should be able to assign count" do
      mission_embedding = MissionEmbedding.new(count: 12)
      
      mission_embedding.super_mission = create(:mission)
      mission_embedding.sub_mission = create(:mission)
      mission_embedding.save!

      MissionEmbedding.first.count.should == 12
    end
    
    it "should be able to assign sub mission title" do
      create(:mission, title: "Sub Mission Title")
      mission_embedding = MissionEmbedding.new(count: 12, sub_mission_title: "Sub Mission Title")
      
      mission_embedding.super_mission = create(:mission)
      mission_embedding.save!
      
      MissionEmbedding.first.sub_mission.title.should == "Sub Mission Title"
    end
  end
  
  describe "virtual attributes" do
    describe  "should query mission by title" do
      it "should find nil if mission title does not exist" do
        mission_embedding = MissionEmbedding.new(count: 10)
      
        mission_embedding.sub_mission_title.should == nil
      end
    
      it "should find skill title if exists" do
        mission_embedding = MissionEmbedding.new(count: 10)
      
        mission_embedding.sub_mission = create(:mission, title: "Mission Name")
      
        mission_embedding.sub_mission_title.should == "Mission Name"
      end
    
      it "find existing skill by title if exists" do
        mission_embedding = MissionEmbedding.new(count: 10)
        
        create(:mission, title: "Existing Title")
        mission_embedding.sub_mission_title = "Existing Title"
        
        Mission.count.should == 1
        Mission.first.title == "Existing Title"
      end
      
      it "should save skill to mission_skill when created" do
        mission = create(:mission)
        create(:mission, title: "Created Title")
        mission_embedding = MissionEmbedding.new(count: 10)
        
        mission.mission_embeddings << mission_embedding
        mission_embedding.sub_mission_title = "Created Title"
        
        mission.save!
        
        Mission.first.mission_embeddings.first.sub_mission.title.should == "Created Title"
      end
    end
  end
end