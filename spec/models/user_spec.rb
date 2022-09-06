require 'rails_helper'

RSpec.describe User,  type: :model do
  let!(:user) { User.new(first_name: "Jon", last_name: "Snow", email: "jon_snow@email.com", password: "iknownothing") }
  context 'validations' do
    it "should fail without first name" do
      user.first_name = nil
      expect(user).to_not be_valid
    end

    it "should fail without last name" do
      user.last_name = nil
      expect(user).to_not be_valid
    end

    it "should fail without email" do
      user.email = nil
      expect(user).to_not be_valid
    end

    it "should fail without password" do
      user.password = nil
      expect(user).to_not be_valid
    end

    it "should fail when passwords is less than 6 characters" do
      user.password = "x" * 5
      expect(user).to_not be_valid
    end
    
    it "should fail without role" do
      user.role = nil
      expect(user).to_not be_valid
    end

    it "should fail when role is neither trader/admin" do
      user.role = "something else"
      expect(user).to_not be_valid

      user.role = "admin"
      expect(user).to be_valid
    end
    
    it "should fail without status" do
      user.status = nil
      expect(user).to_not be_valid
    end

    it "should fail when status is neither pending/approved" do
      user.status = "something else"
      expect(user).to_not be_valid
    end

    it "should fail without balance" do
      user.balance = nil
      expect(user).to_not be_valid
    end

    it "should fail when balance is not numeric" do
      user.balance = "string"
      expect(user).to_not be_valid
    end

    it "should fail when balance is negative" do
      user.balance = -1
      expect(user).to_not be_valid
    end
  end
end