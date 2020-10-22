# frozen_string_literal: true

module TasksHelper
  def markdown(text)
    return if text.blank?

    renderer = Redcarpet::Render::HTML.new(hard_wrap: true)
    sanitize(Redcarpet::Markdown.new(renderer, markdown_options).render(text))
  end

  def markdown_options
    {
      autolink: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      lax_html_blocks: true,
      strikethrough: true,
      superscript: true
    }
  end
end
