# spec/policies/public_email_record_policy_spec.rb
require 'rails_helper'

RSpec.describe PublicEmailRecordPolicy do
  subject { described_class }

  let(:user) { create(:user) }
  let(:record) { create(:public_email_record) }

  describe "#show?" do
    it "permite al usuario autenticado ver el registro" do
      policy = described_class.new(user, record)
      expect(policy.show?).to eq(true)
    end
  end

  describe "#create?" do
    it "deniega creación de registros desde la API" do
      policy = described_class.new(user, record)
      expect(policy.create?).to eq(false)
    end
  end

  describe "#update?" do
    it "deniega edición de registros desde la API" do
      policy = described_class.new(user, record)
      expect(policy.update?).to eq(false)
    end
  end

  describe "#destroy?" do
    it "deniega borrado de registros desde la API" do
      policy = described_class.new(user, record)
      expect(policy.destroy?).to eq(false)
    end
  end
end
