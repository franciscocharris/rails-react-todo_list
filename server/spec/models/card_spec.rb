# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Card, type: :model do
  subject { build(:card) }

  describe 'Validations' do
    %i[name n_position].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end
    it { is_expected.to validate_uniqueness_of(:n_position).scoped_to(:user_id).case_insensitive }
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:user) }
  end
end
