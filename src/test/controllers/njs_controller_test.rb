require 'test_helper'

class NjsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @nj = njs(:one)
  end

  test "should get index" do
    get njs_url
    assert_response :success
  end

  test "should get new" do
    get new_nj_url
    assert_response :success
  end

  test "should create nj" do
    assert_difference('Nj.count') do
      post njs_url, params: { nj: { address: @nj.address, description: @nj.description, name: @nj.name, verified: @nj.verified } }
    end

    assert_redirected_to nj_url(Nj.last)
  end

  test "should show nj" do
    get nj_url(@nj)
    assert_response :success
  end

  test "should get edit" do
    get edit_nj_url(@nj)
    assert_response :success
  end

  test "should update nj" do
    patch nj_url(@nj), params: { nj: { address: @nj.address, description: @nj.description, name: @nj.name, verified: @nj.verified } }
    assert_redirected_to nj_url(@nj)
  end

  test "should destroy nj" do
    assert_difference('Nj.count', -1) do
      delete nj_url(@nj)
    end

    assert_redirected_to njs_url
  end
end
