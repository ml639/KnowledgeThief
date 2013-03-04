require 'spec_helper'

describe "flags/index" do
  before(:each) do
    assign(:flags, [
      stub_model(Flag,
        :item_id => 1,
        :itemtype => "Itemtype",
        :desc => "Desc",
        :reporter_id => 2,
        :resolved => false,
        :moderator_id => 3,
        :moderator_msg => "Moderator Msg",
        :action => "Action",
        :checked => false
      ),
      stub_model(Flag,
        :item_id => 1,
        :itemtype => "Itemtype",
        :desc => "Desc",
        :reporter_id => 2,
        :resolved => false,
        :moderator_id => 3,
        :moderator_msg => "Moderator Msg",
        :action => "Action",
        :checked => false
      )
    ])
  end

  it "renders a list of flags" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Itemtype".to_s, :count => 2
    assert_select "tr>td", :text => "Desc".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Moderator Msg".to_s, :count => 2
    assert_select "tr>td", :text => "Action".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
