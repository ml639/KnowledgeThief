require 'spec_helper'

describe "flags/new" do
  before(:each) do
    assign(:flag, stub_model(Flag,
      :item_id => 1,
      :itemtype => "MyString",
      :desc => "MyString",
      :reporter_id => 1,
      :resolved => false,
      :moderator_id => 1,
      :moderator_msg => "MyString",
      :action => "MyString",
      :checked => false
    ).as_new_record)
  end

  it "renders new flag form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => flags_path, :method => "post" do
      assert_select "input#flag_item_id", :name => "flag[item_id]"
      assert_select "input#flag_itemtype", :name => "flag[itemtype]"
      assert_select "input#flag_desc", :name => "flag[desc]"
      assert_select "input#flag_reporter_id", :name => "flag[reporter_id]"
      assert_select "input#flag_resolved", :name => "flag[resolved]"
      assert_select "input#flag_moderator_id", :name => "flag[moderator_id]"
      assert_select "input#flag_moderator_msg", :name => "flag[moderator_msg]"
      assert_select "input#flag_action", :name => "flag[action]"
      assert_select "input#flag_checked", :name => "flag[checked]"
    end
  end
end
