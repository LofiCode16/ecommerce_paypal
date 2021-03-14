require 'rails_helper'

RSpec.describe User, type: :model do

  subject {
    described_class.new(
      email: 'test@mail.com',
      encrypted_password: 'abc123'
    )
  }

  
  it 'can have many orders' do
    expect(subject.orders).to_not be_nil
  end

end
