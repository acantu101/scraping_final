RSpec.describe Kefoto do
  it "has a version number" do
    expect(Kefoto::VERSION).not_to be nil
  end

  it "converts uses user input to select a proudct" do
    expect(select_from_list_cli).to eq(true)

  end
end
