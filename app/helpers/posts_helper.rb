module PostsHelper
  def render_post_updated_at(post)
    post.updated_at.to_s(:long)
  end
end
