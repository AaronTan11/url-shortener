class ShortUrlsController < ApplicationController
  before_action :authenticate_user!, except: [:redirect]

  def index
    @target_urls = current_user.target_urls.includes(:short_urls).order(created_at: :desc)
  end

  def new
    @short_url = ShortUrl.new
  end

  def create
    target_url = current_user.target_urls.find_or_initialize_by(target_url: short_url_params[:target_url])
    target_url.title_tag = get_title_tag(target_url.target_url) if target_url.new_record?

    @short_url = target_url.short_urls.new(path: generate_unique_path)

    if target_url.save && @short_url.save
      redirect_to short_urls_path, notice: 'Short URL was successfully created.'
    else
      flash.now[:alert] = 'Failed to create Short URL.'
      render :new
    end
  end

  def show
    @short_url = ShortUrl.find_by(path: params[:id])
    if @short_url
      @analytics = @short_url.analytics.order(clicked_at: :desc).includes(:short_url)
      @total_clicks = @analytics.count
      @unique_visitors = @analytics.pluck(:ip_address).uniq.count
      @top_country = @analytics.group(:country).count.max_by { |_, v| v }&.first || 'N/A'
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

    # Broadcast the analytic to the analytics channel
    AnalyticsChannel.broadcast_to(@short_url, analytic)

    Rails.logger.debug "Created analytic: #{analytic.inspect}"
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error "Failed to create analytic: #{e.message}"
  end
end
