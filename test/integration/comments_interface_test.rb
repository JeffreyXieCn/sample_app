require 'test_helper'

class CommentsInterfaceTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @user = users(:michael)
    @micropost = microposts(:orange)
  end

  test "comment interface" do
    log_in_as(@user)
    get root_path
    
    # Invalid submission
    assert_no_difference 'Comment.count' do
      post micropost_comments_path(@micropost), params: { comment: { content: "" } }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_select "div.alert-danger"
    assert_match "Invalid comment", response.body
    
    # Valid submission
    content = "This is a very valuable comment"
    assert_difference 'Comment.count', 1 do
      post micropost_comments_path(@micropost), params: { comment: { content: content } }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match content, response.body
    
    # Delete comment
    first_comment = @micropost.comments.first
    assert_select "a[href=?]", micropost_comment_path(first_comment.micropost, first_comment), text: 'delete'
    
    # Shouldn't be able to delete other people's comments on your own post
    archerComment = users(:archer).comments.first
    assert_select "a[href=?]", micropost_comment_path(archerComment.micropost, archerComment), text: 'delete', count: 0
    
    assert_difference 'Comment.count', -1 do
      delete micropost_comment_path(first_comment.micropost, first_comment)
    end
    
    # Visit different user (no delete links)
    get user_path(users(:archer))
    assert_select 'a', text: 'delete', count: 0
  end
end
