# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :redirect_if_logged_in, only: %i[index]

  def index; end

  private

  def redirect_if_logged_in
    redirect_to short_urls_path if current_user
  end
end
