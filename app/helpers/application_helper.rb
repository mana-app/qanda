module ApplicationHelper
  def markdown(text)
    render_options = {
      filter_html: true,
      hard_wrap: true
    }
  
    extensions = {
      autolink: true,
      fenced_code_blocks: true,
      lax_spacing: true,
      no_intra_emphasis: true,
      strikethrough: true,
      superscript: true,
      tables: true,
    }

    # renderer = Redcarpet::Render::HTML.new(render_options)
    renderer = RougeConfig::RougeRender.new(render_options)
    Redcarpet::Markdown.new(renderer, extensions).render(text).html_safe
  end
end
