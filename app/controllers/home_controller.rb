class HomeController < ApplicationController

  def about
    md = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    content = md.render(File.open(Rails.root + "README.md", 'r').read)
    render :text => content
  end

end
