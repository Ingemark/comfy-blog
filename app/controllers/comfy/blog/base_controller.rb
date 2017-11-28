class Comfy::Blog::BaseController < Comfy::Cms::BaseController

  before_action :load_blog

protected

  def load_cms_site
    super
    if @cms_site.path.blank? && params[:cms_path].present?
      raise ActionController::RoutingError.new('Site Not Found')
    end
  end

  def load_blog
    @blog = if @cms_site.blogs.count <= 1
      @cms_site.blogs.first!
    else
      @cms_site.blogs.where(:path => params[:blog_path]).first!
    end

  rescue ActiveRecord::RecordNotFound
    raise ActionController::RoutingError.new('Blog Not Found')
  end

end