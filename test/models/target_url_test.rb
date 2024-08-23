# frozen_string_literal: true

require 'test_helper'

class TargetUrlTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @target_url = TargetUrl.new(target_url: 'https://example.com', title_tag: 'Example', user: @user)
  end

  test 'should be valid' do
    assert @target_url.valid?
  end

  test 'target_url should be present' do
    @target_url.target_url = '     '
    assert_not @target_url.valid?
  end

  test 'title_tag should be present' do
    @target_url.title_tag = '     '
    assert_not @target_url.valid?
  end

  test 'target_url should be unique for each user' do
    duplicate_target_url = @target_url.dup
    @target_url.save
    assert_not duplicate_target_url.valid?
  end

  test 'should belong to user' do
    assert_respond_to @target_url, :user
  end

  test 'should have many short_urls' do
    assert_respond_to @target_url, :short_urls
  end
end
