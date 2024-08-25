require 'rails_helper'

RSpec.describe ToDo, type: :model do
    # Associations tests
    describe 'associations' do
        it { should have_many(:attachments) } 
        it { should belong_to(:group) } 
    end
    # Validation tests
    describe 'validations' do
        it { should validate_presence_of(:group) }
        it { should validate_presence_of(:date_creation) }
        it { should validate_presence_of(:title) }
    end
end