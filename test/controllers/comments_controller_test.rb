require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @micropost = microposts(:orange)
  end
  
  test "should redirect create when not logged in" do
    assert_no_difference 'Comment.count' do
      post micropost_comments_path(@micropost), params: { comment: { content: "Lorem ipsum" } }
    end
    assert_redirected_to login_url
  end
  
  test "should redirect destroy when not logged in" do
    comment = @micropost.comments.first
    assert_no_difference 'Comment.count' do
      delete micropost_comment_path(@micropost, comment)
    end
    assert_redirected_to login_url
  end
  
  test "should redirect destroy for wrong comment" do
    log_in_as(users(:lana))
    comment = comments(:archerComment)
    assert_no_difference 'Comment.count' do
      delete micropost_comment_path(comment.micropost, comment)
    end
    assert_redirected_to root_url
  end
end
