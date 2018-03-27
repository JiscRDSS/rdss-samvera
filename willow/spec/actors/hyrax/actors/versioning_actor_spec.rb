require 'spec_helper'

RSpec.describe Hyrax::Actors::VersioningActor do
  let(:ability) { ::Ability.new(depositor) }
  let(:terminator) { Hyrax::Actors::Terminator.new }
  let(:depositor) { create(:user) }
  let(:active_state) {Vocab::FedoraResourceStatus.active}
  let(:inactive_state) {Vocab::FedoraResourceStatus.inactive}
  let(:original_object_uuid) { SecureRandom.uuid }
  let(:approved_rdss_cdm) {
    create(:rdss_cdm,
      title: ["test title"],
      object_version: "1",
      object_uuid: original_object_uuid,
      state: active_state)
    }

  let(:unapproved_rdss_cdm) {
      create(:rdss_cdm,
        title: ["test title"],
        object_version: "1",
        object_uuid: original_object_uuid,
        state: inactive_state)
      }

  subject(:middleware) do
    stack = ActionDispatch::MiddlewareStack.new.tap do |middleware|
      middleware.use described_class
    end
    stack.build(terminator)
  end
  describe "update with no changes" do
    let(:attributes) { {:title => ["test title"]} }
    let(:env) { Hyrax::Actors::Environment.new(approved_rdss_cdm, ability, attributes) }

    it 'object version increments to 2' do
      expect { middleware.update(env) }.to change { env.attributes[:object_version] }.to "2"
    end

    it 'object related identifiers change to include previous object_uuid as is_new_version_of' do
      object_uuid_recorded_in_related_identifiers_as_is_new_version_of_after_update?(env)
    end
  end

  describe "update to title" do
    let(:attributes) { {:title => ["another test title"]} }
    let(:env) { Hyrax::Actors::Environment.new(approved_rdss_cdm, ability, attributes) }

    it 'object version increments to 2' do
      expect { middleware.update(env) }.to change { env.attributes[:object_version] }.to "2"
    end

    it 'object related identifiers change to include previous object_uuid as is_new_version_of' do
      object_uuid_recorded_in_related_identifiers_as_is_new_version_of_after_update?(env)
    end
  end

  describe "update to uploaded files" do
    let(:attributes) { {:uploaded_files => [1,2]} }
    let(:env) { Hyrax::Actors::Environment.new(approved_rdss_cdm, ability, attributes) }

    it 'object version increments to 2' do
      expect { middleware.update(env) }.to change { env.attributes[:object_version] }.to "2"
    end

    it 'object related identifiers change to include previous object_uuid as is_new_version_of' do
      object_uuid_recorded_in_related_identifiers_as_is_new_version_of_after_update?(env)
    end
  end

  describe "unpublished update to title" do
    let(:attributes) { {:title => ["another test title"]} }
    let(:env) { Hyrax::Actors::Environment.new(unapproved_rdss_cdm, ability, attributes) }

    it 'object version increments to 2' do
      expect { middleware.update(env) }.not_to change { env.attributes[:object_version] }
    end

    it 'object related identifiers change to not include previous object_uuid as is_new_version_of' do
      !object_uuid_recorded_in_related_identifiers_as_is_new_version_of_after_update?(env)
    end
  end

  def object_uuid_recorded_in_related_identifiers_as_is_new_version_of_after_update? env
    middleware.update(env)

    if env.attributes[:object_related_identifiers_attributes].present?
      expect(last_recorded_related_identifier_value(env)).to eq(original_object_uuid)
      expect(last_recorded_related_identifier_relation_type(env)).to eq('is_new_version_of')
    else
      false
    end
  end

  def last_recorded_related_identifier_relation_type env
    env.attributes[:object_related_identifiers_attributes][last_recorded_related_identifier_index(env)]['relation_type']
  end

  def last_recorded_related_identifier_value env
    env.attributes[:object_related_identifiers_attributes][last_recorded_related_identifier_index(env)]['identifier_attributes']['identifier_value']
  end

  def last_recorded_related_identifier_index env
    (env.attributes[:object_related_identifiers_attributes].values.count-1).to_s
  end
end
