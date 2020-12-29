require 'rails_helper'

RSpec.describe Search, type: :model do
  subject { described_class.new }

  it 'validates' do
    expect(subject).not_to be_valid
    expect(subject.errors[:query]).to include "can't be blank"
    expect(subject.errors[:body]).to include "can't be blank"
  end
end
