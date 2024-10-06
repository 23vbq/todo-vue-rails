require 'rails_helper'

RSpec.describe Attachment, type: :model do
    # Associations tests
    describe 'associations' do
        it { should belong_to(:to_do) }
    end
    # Validation tests
    describe 'validations' do
        it { should validate_presence_of(:to_do_id) }
        it { should validate_presence_of(:data) }
    end
end
