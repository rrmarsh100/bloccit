RSpec.describe User, type: :model do
  let(:user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "password") }
  let(:user_with_invalid_name) { User.new(name: "", email: "user@bloccit.com") }
  let(:user_with_invalid_email) { User.new(name: "Bloccit User", email: "") }
  let(:user_with_caps_name) { User.create!(name: "BLOCCIT USER", email: "user1@bloccit.com", password: "password") }
  let(:user_with_lowercase_name) { User.create!(name: "bloccit user", email: "user2@bloccit.com", password: "password") }

  # shoulda tests for name
  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_least(1) }

  # shoulda tests for email
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_length_of(:email).is_at_least(3) }
  it { should allow_value("user@bloccit.com").for(:email) }

  # shoulda tests for password
  it { should validate_presence_of(:password) }
  it { should have_secure_password }
  it { should validate_length_of(:password).is_at_least(6) }

  describe "attributes" do
    it "should have name and email attributes" do
      expect(user).to have_attributes(name: "Bloccit User", email: "user@bloccit.com")
    end
  end

  describe "invalid user" do
    it "should be an invalid user due to blank name" do
      expect(user_with_invalid_name).to_not be_valid
    end

    it "should be an invalid user due to blank email" do
      expect(user_with_invalid_email).to_not be_valid
    end
  end

  describe "#normalize_name" do
    it "should capitalize first and last names" do
      expect(user_with_caps_name).to have_attributes(name: "Bloccit User")
      expect(user_with_lowercase_name).to have_attributes(name: "Bloccit User")
    end
  end
end
