# frozen_string_literal: true

require 'test_helper'

class ShortUrlsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    @target_url = target_urls(:one)
    @short_url = short_urls(:one)
    sign_in @user
  end

  test 'should get index' do
    get short_urls_url
    assert_response :success
  end

  test 'should get new' do
    get new_short_url_url
    assert_response :success
  end

  test 'should create short_url' do
    assert_difference('ShortUrl.count') do
      post short_urls_url, params: { short_url: { target_url: 'https://example.com' } }
    end

    assert_redirected_to short_urls_url
  end

  test 'should show short_url' do
    get short_url_url(@short_url)
    assert_response :success
  end

  test 'should redirect short_url' do
    get short_url(@short_url.path)
    assert_redirected_to @short_url.target_url.target_url
  end

  test 'should handle not found short_url' do
    get short_url('nonexistent')
    assert_response :not_found
  end
end
