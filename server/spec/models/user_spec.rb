# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  describe 'Validations' do
    %i[first_name last_name email password].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end
  end

  it { is_expected.to be_valid }
end
