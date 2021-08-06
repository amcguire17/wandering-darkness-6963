class PatchesController < ApplicationController
  def destroy
    patch = Patch.find_plant_plot(params[:id], params[:plant])
    Patch.destroy(patch.id)
    redirect_to '/plots'
  end
end
