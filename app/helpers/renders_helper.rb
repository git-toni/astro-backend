module RendersHelper
  def render_feedback(msg=[], status= :unauthorized)
    render json: msg, status: status
  end
end
