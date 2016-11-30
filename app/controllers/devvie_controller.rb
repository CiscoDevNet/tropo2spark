class DevvieController < ApplicationController

  def index
    response = Devvie.index request.env["rack.input"].read
    render :json => response
  end

end
