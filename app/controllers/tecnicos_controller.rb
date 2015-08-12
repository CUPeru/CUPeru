class TecnicosController < ApplicationController
  def show
    @tecnico = Tecnico.find(params[:id])
  end
end

