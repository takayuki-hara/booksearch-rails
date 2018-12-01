require 'test_helper'

class ReleaseWatchesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @release_watch = release_watches(:one)
  end

  test "should get index" do
    get release_watches_url
    assert_response :success
  end

  test "should get new" do
    get new_release_watch_url
    assert_response :success
  end

  test "should create release_watch" do
    assert_difference('ReleaseWatch.count') do
      post release_watches_url, params: { release_watch: { book_id: @release_watch.book_id, sales_date: @release_watch.sales_date, user_id: @release_watch.user_id } }
    end

    assert_redirected_to release_watch_url(ReleaseWatch.last)
  end

  test "should show release_watch" do
    get release_watch_url(@release_watch)
    assert_response :success
  end

  test "should get edit" do
    get edit_release_watch_url(@release_watch)
    assert_response :success
  end

  test "should update release_watch" do
    patch release_watch_url(@release_watch), params: { release_watch: { book_id: @release_watch.book_id, sales_date: @release_watch.sales_date, user_id: @release_watch.user_id } }
    assert_redirected_to release_watch_url(@release_watch)
  end

  test "should destroy release_watch" do
    assert_difference('ReleaseWatch.count', -1) do
      delete release_watch_url(@release_watch)
    end

    assert_redirected_to release_watches_url
  end
end
