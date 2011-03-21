class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale
  before_filter :set_theme

  def set_locale
    # if params[:locale] is nil then I18n.default_locale will be used
    host = request.host.split('.').first
    I18n.locale = :fr if host == "ccapao"
    I18n.locale = params[:locale]
  end

  def set_theme
    @theme = 'global'
    if ['global','green', 'red'].include? params[:theme]
      @theme = params[:theme]
    end
  end
    
  def default_url_options(options={})
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { :locale => I18n.locale, :theme => @theme }
  end
    
end
