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
end
