require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module IlluminatiNeon
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.paths.add 'lib', eager_load: true
    # KKe-coder added
    ## create slim
    config.generators.template_engine = :slim
    ## timezone jpn
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
    ## i18n-ja
    config.i18n.default_locale = :ja
    ## config_error_message
    config.action_view.field_error_proc = Proc.new do |html_tag, instance|
      if instance.kind_of?(ActionView::Helpers::Tags::Label)
        html_tag.html_safe
      else
        class_name = instance.object.class.name.underscore
        method_name = instance.instance_variable_get(:@method_name)
        "<div class=\"has-error\">#{html_tag}
          <span class=\"alert alert-info align-middle\">
            <i class=\"fas fa-exclamation-triangle\"></i>
            #{I18n.t("activerecord.attributes.#{class_name}.#{method_name}")}
            #{instance.error_message.first}
          </span>
        </div>".html_safe
      end
    end
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
