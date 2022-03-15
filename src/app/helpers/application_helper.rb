# frozen_string_literal: true

# Helper functions made here are accessable in all views
# for example, app_name is now accessable to all views

APP_NAME = './poverty/resources'

module ApplicationHelper
  def app_name
    conf = app_config
    if conf.nil?
      '?'
    else
      APP_NAME
    end
  end

  private

  def app_config
    AppConfig.first
  end
end
