require 'rails_helper'

describe "ActsAsAdminstering" do
  before(:each) do
    @person = Person.create
    @organization = Organization.create
  end

  describe "acts_as_administrating :foos, class_name: 'Organization'" do
    it "@person.adminstrates_foos? is true" do 
      expect(@person.administrates_foos?).to be_truthy
    end
    context "before telling @person to administrate @organization as a foo" do 
      it "@person.administrated_foos.count is 0" do 
        expect(@person.administrated_foos.count).to eq(0)
      end
    end
    context "when telling @person to administrate @organization as a foo" do 
      it "creates a new relationship" do 
        expect{@person.administrate_this_foo @organization}.to change{ActsAsRelatingTo::Relationship.count}.by(1)
      end
      it "returns true" do 
        expect(@person.administrate_this_foo @organization).to be_truthy
      end
    end
    context "after telling @person to administrate @organization as a foo" do 
      before(:each) do 
        @person.administrate_this_foo @organization
      end
      it "@person.administrates_this_foo?(@organization) to be true" do 
        expect(@person.administrates_this_foo?(@organization)).to be_truthy
      end
      it "@person.relates_to_as?(@organization,'admin') is true" do 
        expect(@person.relates_to_as?(@organization,'admin')).to be_truthy
      end
      it "@person.administrated_foos includes @organization" do 
        expect(@person.administrated_foos).to include(@organization)
      end
      it "@person.administrated_foos.count is 1" do 
        expect(@person.administrated_foos.count).to eq(1)
      end
      context "when telling @person to stop administrating @organization as a foo" do 
        it "does not remove the relationship" do 
          expect{@person.stop_administrating_this_foo @organization}.to change{ActsAsRelatingTo::Relationship.count}.by(0)
        end
        context "after tellling @person to stop administrating @organization as a foo" do 
          before(:each) do 
            @person.stop_administrating_this_foo @organization 
          end
          it "@person no longer administrates @organization" do 
            expect(@person.administrates_this_foo?(@organization)).to be_falsey
          end
          it "@person has no administrated foos" do 
            expect(@person.administrated_foos.count).to eq(0)
          end
        end
      end
    end
  end
end