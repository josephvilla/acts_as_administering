require 'rails_helper'

describe "ActsAsAdminstering" do
  before(:each) do
    @person = Person.create
    @organization = Organization.create
  end

  describe "when included in the Person class using 'acts_as_administrating :organizations':" do

    describe "#administrate_this_thing" do
      describe "when the administrated_thing is @organization:" do
        context "before the thing is added" do
          it "increases ActsAsRelating::Relationship.count by 1" do
            expect{@person.administrate_this_organization @organization}.to change{ActsAsRelatingTo::Relationship.count}.by(1)
          end
          it "returns true" do
            expect(@person.administrate_this_organization @organization).to be_truthy
          end
          it "@person.administrated_organizations.count is 0" do
            expect(@person.administrated_organizations.count).to eq(0)
          end
        end
        context "after the thing is added" do 
          before(:each) do
            @person.administrate_this_organization @organization
          end
          it "@person.relates_to_as?(@organization,'admin') is true" do
            @person.administrate_this_organization @organization
            expect(@person.relates_to_as?(@organization,'admin')).to be_truthy
          end
          it "@person.administered_organizations.count is 1" do
            expect((@person.administrated_organizations).count).to eq(1)
          end
          it "@person.administered_organizations includes @organization" do
            expect(@person.administrated_organizations).to include(@organization)
          end
          it "@person.administrates_this_organization?(@organization) is true" do 
            expect(@person.administrates_this_organization?(@organization)).to be_truthy
          end
        end
      end
      describe "when the administrated_thing is @program:" do
        it "raises 'NoMethodError'" do 
          @program = Program.create
          expect{@person.administrate_this_program @program}.to raise_error(NoMethodError)
        end
      end
    end
    describe "#administrated_things" do
      describe "before '@person.administrate_this_organization @organization:" do 
      end
      describe "after the #administrate @organization call:" do
        before(:each) do
          @person.administrate_this_organization @organization
        end
      end 

    end
=begin

    xdescribe "#administered_things" do
      before(:each) do 
        @person.administrate @organization
      end
      describe "when 'things' is 'organizations'" do
        it "@person.administered_organizations includes @organization" do
          expect(@person.administered_organizations.include?(@organization)).to be_truthy
        end
      end
      describe "when 'things' is 'programs' (and 'programs' is not an administered type of thing)" do
        it "@person.administered_programs raises a NoMethodError" do
          expect{@person.administered_programs}.to raise_error(NoMethodError)
        end
      end
    end

    xdescribe "#administers?" do
      it "returns false before the #administrate call" do
        expect(@person.administers? @organization).to be_falsey
      end
      it "returns true after the #administrate call" do
        @person.administrate @organization
        expect(@person.administers? @organization).to be_truthy
      end

    end

    xdescribe "#administers_[things]?" do
      describe "when [things] is 'organizations'" do 
        it "responds to 'administers_organizations?'" do
          expect(@person.respond_to?("administers_organizations?")).to be_truthy
        end
        it "returns true" do
          expect(@person.administers_organizations?).to be_truthy
        end
      end
      describe "when [things] is 'programs'" do 
        it "does not respond to 'administers_programs?'" do
          expect(@person.respond_to?("administers_programs?")).to be_falsey
        end
      end
    end
=end
  end
end