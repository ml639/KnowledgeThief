require 'spec_helper'

describe "paths/edit" do
  before(:each) do
    @path = assign(:path, stub_model(Path,
      :name => "MyString",
      :content => "MyText"
    ))
  end

  it "renders the edit path form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => paths_path(@path), :method => "post" do
      assert_select "input#path_name", :name => "path[name]"
      assert_select "textarea#path_content", :name => "path[content]"
    end
  end
end
