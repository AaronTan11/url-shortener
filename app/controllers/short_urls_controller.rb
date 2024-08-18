class ShortUrlsController < ApplicationController
  before_action :authenticate_user!, except: [:redirect]

  def index
    @target_urls = TargetUrl.includes(:short_urls).all
  end

  def new
    @short_url = ShortUrl.new
  end

  def create
    target_url = TargetUrl.find_or_initialize_by(target_url: short_url_params[:target_url])
    target_url.update(title_tag: get_title_tag(target_url.target_url))

    @short_url = ShortUrl.new(path: generate_unique_path, target_url:)

    if @short_url.save
      redirect_to short_urls_path, notice: 'Short URL was successfully created.'
    else
      render :new
    end
  end

  def show
    @short_url = ShortUrl.find_by(path: params[:id])
    if @short_url
      @analytics = @short_url.analytics.order(clicked_at: :desc)
      Rails.logger.debug "Analytics count: #{@analytics.count}"
      Rails.logger.debug "First analytic: #{@analytics.first.inspect}" if @analytics.any?
    else
      render :not_found, status: :not_found
    end
  end

  def redirect
    @short_url = ShortUrl.find_by(path: params[:id])
    if @short_url
      record_analytics
      redirect_to @short_url.target_url.target_url, allow_other_host: true
    else
      render :not_found, status: :not_found
    end
  end

  private

  def short_url_params
    params.require(:short_url).permit(:target_url)
  end

  def generate_unique_path
    loop do
      path = SecureRandom.alphanumeric(rand(6...10))
      break path unless ShortUrl.exists?(path:)
    end
  end

  def get_title_tag(url)
    doc = Nokogiri::HTML(URI.open(url))
    doc.at_css('title')&.text
  rescue StandardError => e
    Rails.logger.error("Error fetching title for #{url}: #{e.message}")
    url
  end

  def record_analytics
    location = request.location
    analytic = @short_url.analytics.create!(
      ip_address: request.remote_ip,
      country: location.country,
      city: location.city,
      clicked_at: Time.current
    )
    Rails.logger.debug "Created analytic: #{analytic.inspect}"
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error "Failed to create analytic: #{e.message}"
  end
end
