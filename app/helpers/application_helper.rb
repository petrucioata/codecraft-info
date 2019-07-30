# frozen_string_literal: true

module ApplicationHelper
  def romanian_format(date)
    date.strftime('%d %B %Y')
  rescue StandardError
    ''
  end

  def error_messages(error)
    error&.full_messages&.join("\n")
  end

  def active_css_class(link_path)
    current_page?(link_path) ? 'active' : ''
  end
end
