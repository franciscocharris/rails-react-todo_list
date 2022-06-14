# frozen_string_literal: true

require 'rails_helper'
RSpec.describe JwtServices::Decoder do
  subject { described_class }
  let(:data) { { 'id' => 1 } }
  let(:token) { JwtServices::Encoder.call(data) }

  it { expect(subject.call(token)).to eq(data) }
end
