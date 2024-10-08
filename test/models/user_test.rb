# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(username: 'testuser', password: 'password123')
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'username should be present' do
    @user.username = '     '
    assert_not @user.valid?
  end

  test 'username should be unique' do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test 'password should be present' do
    @user.password = '     '
    assert_not @user.valid?
  end

  test 'password should have a minimum length' do
    @user.password = 'a' * 5
    assert @user.valid?
  end

  test 'should have many target_urls' do
    assert_respond_to @user, :target_urls
  end
end
