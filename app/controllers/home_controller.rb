class HomeController < ApplicationController

  def about
    md = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    content = md.render(File.open(Rails.root + "README.md", 'r').read)
    render html: content.html_safe
  end

end
