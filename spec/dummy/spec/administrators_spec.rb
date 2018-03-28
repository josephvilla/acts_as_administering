require 'rails_helper'

RSpec.describe Person do
  before(:all) do
    @method_name = :administrators
  end
  describe "#method_name" do

    it "organization responds to :administrators" do 
      expect(organization.respond_to?(@method_name)).to be_truthy
    end 

    context "when doing person.administrated_organizations << organization" do 
      it "ActsAsRelatingTo::Relationship changes by 1" do 
        expect{person.administrated_organizations << organization}.to change{ActsAsRelatingTo::Relationship.count}.by(1)
      end
    end # when doing person.administrated_organizations << organization

    context "after doing person.administrated_organizations << organization" do 
      
      before(:each) do 
        person.administrated_organizations << organization
      end
            
      it "the organization has the person as an administrator" do 
        organization.administrators.tap do |result|
          expect(result.include?(person)).to be_truthy
        end
      end

      context "when doing person.administrated_organizations << organization again" do 
        it "changes ActsAsRelatingTo::Relationship by 0" do 
          expect{person.administrated_organizations << organization}.to change{ActsAsRelatingTo::Relationship.count}.by(0)
        end
      end # when doing person.administrated_organizations << organization again

    end # after doing person.administrated_organizations << organization

    context "when using the .administrators method" do 

      context "when adding the person as an administrator" do 

        context "when doing organization.administrators << person" do 
          it "ActsAsRelatingTo::Relationship.count changes by 1" do 
            expect{organization.administrators << person}.to change{ActsAsRelatingTo::Relationship.count}.by(1)
          end
        end # when doing administrators <<

        context "after doing organization.administrators << person" do 
          before(:each){ organization.administrators << person }
          
          it "organization has person as administrator" do 
            expect(organization.administrators.include?(person)).to be_truthy
          end
          
          context "when removing the person as an administrator" do 
            it "ActsAsRelatingTo::Relationship.count changes by -1" do 
              expect{organization.administrators.remove(person)}.to change{ActsAsRelatingTo::Relationship.count}.by(-1)
            end
          end
          
          context "after removing the person as an administrator" do 
            before(:each){ organization.administrators.remove(person) }
            it "the person does not administrate the organization" do 
              expect(person.administrates_this_organization?(organization)).to be_falsey
            end
          end

        end # after doing organization.administrators << person

      end # when adding the person as an administrator

      context "when adding the organization as an administrator" do 

        it "raises a RuntimeError" do 
          expect{organization.administrators << organization}.to raise_error(RuntimeError)
        end

        it "ActsAsRelatingTo::Relationship changes by 0" do 
          expect{(organization.administrators << organization) rescue nil}.to change{ActsAsRelatingTo::Relationship.count}.by(0)
        end

      end # when adding the organization as an administrator

    end # when using the .administrators method

  end
end

def person;       @person ||= Person.create!              end
def organization; @organization ||= Organization.create!  end
def program;      @program ||= Program.create!            end