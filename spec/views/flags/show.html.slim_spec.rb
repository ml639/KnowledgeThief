require 'spec_helper'

describe "flags/show" do
  before(:each) do
    @flag = assign(:flag, stub_model(Flag,
      :item_id => 1,
      :itemtype => "Itemtype",
      :desc => "Desc",
      :reporter_id => 2,
      :resolved => false,
      :moderator_id => 3,
      :moderator_msg => "Moderator Msg",
      :action => "Action",
      :checked => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Itemtype/)
    rendered.should match(/Desc/)
    rendered.should match(/2/)
    rendered.should match(/false/)
    rendered.should match(/3/)
    rendered.should match(/Moderator Msg/)
    rendered.should match(/Action/)
    rendered.should match(/false/)
  end
end
