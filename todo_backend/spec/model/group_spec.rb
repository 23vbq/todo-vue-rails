require 'rails_helper'

RSpec.describe Group, type: :model do
    # Associations tests
    describe 'associations' do
        it { should have_many(:to_dos) } 
    end
    # Validation tests
    describe 'validations' do
        it { should validate_presence_of(:name) }
        it { should validate_uniqueness_of(:name) }
        it { should validate_length_of(:name).is_at_most(20)}
    end
end