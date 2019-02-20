module ApplicationHelper
  def render_model_created_at(model)
    model.created_at.strftime('%F %H:%M')
  end

  def render_model_content(model)
    truncate(simple_format(model.content), lenth: 100)
  end
end
