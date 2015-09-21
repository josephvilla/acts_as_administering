require 'rails_helper'

describe "ActsAsAdminstering" do
  before(:each) do
    @person = Person.create
    @organization = Organization.create
  end

  describe "when included in the Person class using 'acts_as_administering :organizations':" do

    describe "#administer(administered_thing)" do
      describe "when the administered_thing is @organization:" do
        it "increases ActsAsRelating::Relationship.count by 1" do
          expect{@person.administer @organization}.to change{ActsAsRelatingTo::Relationship.count}.by(1)
        end
        it "returns true" do
          expect(@person.administer @organization).to be_truthy
        end
        it "@person.relates_to_as?(@organization,'admin') is true" do
          @person.administer @organization
          expect(@person.relates_to_as?(@organization,'admin')).to be_truthy
        end
      end
      describe "when the administered_thing is @program:" do
        it "raises 'NoMethodError'" do 
          @program = Program.create
          expect{@person.administer @program}.to raise_error(NoMethodError)
        end
      end
    end

    describe "#administered [:things]" do
      describe "before '@person.administer @organization:" do 
        it "(person.administered :organizations).count is 0" do
          expect((@person.administered :organizations).count).to eq(0)
        end
      end
      describe "after the #administer @organization call:" do
        before(:each) do
          @person.administer @organization
        end
        it "@administered_organizations.count is 1" do
          expect((@person.administered :organizations).count).to eq(1)
        end
        it "@administered_organizations includes @organization" do
          expect((@person.administered :organizations).include?(@organization)).to be_truthy
        end
      end 

    end

    describe "#administered_things" do
      before(:each) do 
        @person.administer @organization
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

    describe "#administers?" do
      it "returns false before the #administer call" do
        expect(@person.administers? @organization).to be_falsey
      end
      it "returns true after the #administer call" do
        @person.administer @organization
        expect(@person.administers? @organization).to be_truthy
      end

    end

    describe "#administers_[things]?" do
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

  end
end