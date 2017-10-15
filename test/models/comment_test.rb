require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:michael)
    @micropost = @user.microposts.first
    @comment = @micropost.comments.build(content: "A value comment")
    @comment.user = @user
  end
  
  test "should be valid" do
    assert @comment.valid?
  end
  
  test "user id should be present" do
    @comment.user_id = nil
    assert_not @comment.valid?
  end
  
  test "micropost id should be present" do
    @comment.micropost_id = nil
    assert_not @comment.valid?
  end
  
  test "content should be at most 140 characters" do
    @comment.content = "a" * 141
    assert_not @micropost.valid?
  end
  
  test "order should be most recent first" do
    @comment.save  #this comment will become the most recent one
    assert_equal @comment, @micropost.comments.first
  end
end
