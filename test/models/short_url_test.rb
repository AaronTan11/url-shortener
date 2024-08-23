require 'test_helper'

class ShortUrlTest < ActiveSupport::TestCase
  def setup
    @target_url = target_urls(:one)
    @short_url = ShortUrl.new(path: 'abc123', target_url: @target_url)
  end

  test 'should be valid' do
    assert @short_url.valid?
  end

  test 'path should be present' do
    @short_url.path = '     '
    assert_not @short_url.valid?
  end

  test 'path should be unique' do
    duplicate_short_url = @short_url.dup
    @short_url.save
    assert_not duplicate_short_url.valid?
  end

  test 'path should not exceed 6 characters' do
    @short_url.path = 'a' * 7
    assert_not @short_url.valid?
  end

  test 'should belong to target_url' do
    assert_respond_to @short_url, :target_url
  end

  test 'should have many analytics' do
    assert_respond_to @short_url, :analytics
  end
end
