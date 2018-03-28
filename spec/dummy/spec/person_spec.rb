require 'rails_helper'

RSpec.describe Person do
  before(:all) do
    @method_name = "method_name"
  end
  describe "#method_name" do
    context "before adding the administrated organization" do 
      it "the person does not administrate the organization" do 
        expect(person.administrates_this_organization?(organization)).to be_falsey
      end
    end
    context "when adding an administrated organization" do 
      it "changes relationships by 1" do 
        expect{person.administrated_organizations << organization}.to change{ActsAsRelatingTo::Relationship.count}.by(1)
      end
    end
    context "after adding an administrated organization" do 
      before(:each) do 
        person.administrated_organizations << organization
      end
      it "the person administrates the organization" do
        expect(person.administrates_this_organization?(organization)).to be_truthy
      end
      it "the organization has the person as an administrator" do 
        puts "organization.administrators:"<<" #{organization.administrators}".light_blue
      end
      context "when trying to add the organization again" do 
        it "changes relationships by zero" do 
          expect{person.administrated_organizations << organization}.to change{ActsAsRelatingTo::Relationship.count}.by(0)
        end
      end
    end
  end
end

def person;       @person ||= Person.create!              end
def organization; @organization ||= Organization.create!  end
def program;      @program ||= Program.create!            end