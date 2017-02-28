module HooksHelper
  def retrieve_resource model,rid
    begin
      @resource = model.constantize.find(rid)
    rescue
      render json: {msg: "Error finding #{model}"}, status: :not_found
    end
  end
end
