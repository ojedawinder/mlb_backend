class Api::Mlb::LoadersController < ApplicationController


  #POST admin/start_load
  def startLoadData
    start_date = params[:start_date]
    end_date = params[:end_date]
    @load = Loader.start start_date, end_date
    if @load
      render json: {'msg':'Proceso Finalizado exitosamente'}
    else
      render json: {'msg':'Proceso Abortado'}
    end
  end


end
