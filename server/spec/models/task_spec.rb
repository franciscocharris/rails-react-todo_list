require 'rails_helper'

RSpec.describe Task, type: :model do
  let!(:user) { create(:user) }
  subject { build(:task, user_id: user.id, list_id: user.lists[0].id) }
  # let(:f_attributes) { { user_id: user.id, list_id: user.lists[0].id } }

  describe 'Validations' do
    %i[name description list_id].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:list) }
    it { is_expected.to belong_to(:user) }
  end

  it { expect(subject).to be_valid }
end
