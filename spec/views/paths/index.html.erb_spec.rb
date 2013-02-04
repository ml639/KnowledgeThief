require 'spec_helper'

describe "paths/index" do
  before(:each) do
    assign(:paths, [
      stub_model(Path,
        :name => "Name",
        :content => "MyText"
      ),
      stub_model(Path,
        :name => "Name",
        :content => "MyText"
      )
    ])
  end

  it "renders a list of paths" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
