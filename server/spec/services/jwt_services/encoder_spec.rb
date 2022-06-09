# frozen_string_literal: true

require 'rails_helper'

RSpec.describe JwtServices::Encoder do
  subject { described_class }
  let(:payload) { { id: 1 } }

  it { expect(subject.call(payload)).to be_an_instance_of(String) }
end
