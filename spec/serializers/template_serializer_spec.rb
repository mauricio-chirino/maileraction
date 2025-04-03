# spec/serializers/template_serializer_spec.rb
require "rails_helper"

RSpec.describe TemplateSerializer do
  let(:user) { create(:user) }
  let(:template) { create(:template, user: user, shared: true) }
  let(:serializer) { described_class.new(template) }
  let(:serialization) { ActiveModelSerializers::Adapter.create(serializer) }
  let(:json) { JSON.parse(serialization.to_json) }

  it "incluye los atributos básicos" do
    expect(json["template"]["id"]).to eq(template.id)
    expect(json["template"]["name"]).to eq(template.name)
    expect(json["template"]["subject"]).to eq(template.subject)
    expect(json["template"]["shared"]).to eq(true)
  end

  it "incluye la relación con el usuario si shared es true" do
    expect(json["template"]["user"]["id"]).to eq(user.id)
  end
end
