require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  def setup
    @base_title = "Microblog Made by Jeffrey"
  end
  
  test "full title helper" do
    assert_equal @base_title, full_title
    assert_equal "Help | #{@base_title}", full_title("Help")
  end
end