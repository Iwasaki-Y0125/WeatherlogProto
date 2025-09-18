class IntroController < ApplicationController
  def index; end

  def step
    @step = params[:step].to_i

    case @step
    when 1
      render partial: 'step1'
    when 2
      render partial: 'step2'  
    when 3
      render partial: 'step3'
    else
      head :not_found
    end
  end
end
