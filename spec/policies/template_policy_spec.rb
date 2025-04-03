# spec/policies/template_policy_spec.rb
require "rails_helper"

RSpec.describe TemplatePolicy do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:own_template) { create(:template, user: user, shared: false) }
  let(:shared_template) { create(:template, shared: true) }

  subject { described_class }

  permissions :index?, :create? do
    it "permite acceso a usuarios autenticados" do
      expect(subject).to permit(user, Template)
    end
  end

  permissions :show? do
    it "permite ver plantillas propias" do
      expect(subject).to permit(user, own_template)
    end

    it "permite ver plantillas compartidas" do
      expect(subject).to permit(user, shared_template)
    end

    it "no permite ver plantillas ajenas no compartidas" do
      template = create(:template, user: other_user, shared: false)
      expect(subject).not_to permit(user, template)
    end
  end

  permissions :update?, :destroy? do
    it "permite modificar o eliminar plantillas propias" do
      expect(subject).to permit(user, own_template)
    end

    it "no permite modificar o eliminar plantillas ajenas" do
      template = create(:template, user: other_user)
      expect(subject).not_to permit(user, template)
    end
  end
end
