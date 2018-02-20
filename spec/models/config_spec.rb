RSpec.describe Config, type: :model do
  it { should validate_presence_of :api_key }

  it 'should be valid' do
    config = create :config

    expect(config).to be_valid
  end
end
