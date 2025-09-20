class DiariesController < ApplicationController
  def index
    @diaries = current_user.diaries
  end

  def new
    @diary = Diary.new
  end

  def create
  Rails.logger.debug "=== CREATE ACTION START ==="
  Rails.logger.debug "current_user: #{current_user}"
  Rails.logger.debug "current_user.id: #{current_user&.id}"
  Rails.logger.debug "diary_params: #{diary_params}"

  @diary = current_user.diaries.build(diary_params)

  Rails.logger.debug "Built diary: #{@diary.inspect}"
  Rails.logger.debug "Diary valid?: #{@diary.valid?}"
  Rails.logger.debug "Diary errors: #{@diary.errors.full_messages}"

  if @diary.save
    Rails.logger.debug "Diary saved successfully!"
    redirect_to diaries_path, success: "日記を記録しました"
  else
    Rails.logger.debug "Diary save failed: #{@diary.errors.full_messages}"
    flash.now[:danger] = "日記が記録できませんでした"
    render :new, status: :unprocessable_entity
  end
end

  private

  def diary_params
    params.require(:diary).permit(:symptom_level, :oneline_diary).tap do |diary_params|
      diary_params[:symptom_level] = diary_params[:symptom_level].to_i if diary_params[:symptom_level].present?
    end
  end
end
