module RendersHelper
  def render_feedback(msg=[], status= :unauthorized)
    render json: {msg: msg}, status: status
  end
end
