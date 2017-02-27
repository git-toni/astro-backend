module ReqHelper
  def user_params
    params.include?(:user) ?
      params.require(:user).permit(:id)
      : params.permit(:id)
  end
  def user_id
    user_params[:id]
  end
end
