module PaginationHelper
  def paginate(params)
    if params[:page] || params[:per_page]
      if params[:page].to_i > 0 
        params[:page] = params[:page].to_i
      else
        params[:page] = 1
      end
      if params[:per_page] 
        params[:per_page] = params[:per_page].to_i
      else
        params[:per_page] = 20
      end
    else
      params[:per_page] = 20
      params[:page] = 1
    end
    min = (params[:page] - 1) * params[:per_page]
    max = params[:per_page] * params[:page]
    [min, max]
  end
end