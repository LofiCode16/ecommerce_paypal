require 'rails_helper'

RSpec.describe Product, type: :model do

    subject {
        described_class.new(
            name: 'paraguas',
            price: 5000,
            quant: 5
        )
    }

    describe 'validations' do 

        context 'attributes' do
    
            it 'name cant be blank' do
                subject.name = nil

                expect(subject).to_not be_valid
            end

            it 'price cant be less than 10' do
                subject.price = 9

                expect(subject).to_not be_valid
            end

        end

        context 'associations' do
        
            it 'is present in many categories' do
                expect(subject.categories).to_not be_nil
            end
        
        end

    end

end