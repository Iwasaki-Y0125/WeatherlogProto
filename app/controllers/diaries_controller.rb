require "httparty"

class DiariesController < ApplicationController
  def index
    @diaries = current_user.diaries.includes(:weather).order(created_at: :desc)
  end

  def new
    @diary = Diary.new
  end

  def create
    @diary = current_user.diaries.build(diary_params)
    weather_data = get_weather_data

    if @diary.save
      if weather_data
        weather = current_user.weathers.create!(
          temperature: weather_data[:temperature],
          weather_code: weather_data[:weather_code].to_s,
          pressure: weather_data[:pressure],
          humidity: weather_data[:humidity],
        )
        @diary.update!(weather: weather)
      end
      redirect_to diaries_path, success: "日記を記録しました"
    else
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

  def get_weather_data
    # ユーザーの位置情報チェック
    unless current_user.latitude && current_user.longitude
      return nil
    end

    lat = current_user.latitude
    lon = current_user.longitude

    begin
      response = HTTParty.get("https://api.open-meteo.com/v1/forecast", {
        query: {
          latitude: lat,
          longitude: lon,
          current: "temperature_2m,weather_code,pressure_msl,relative_humidity_2m",
          timezone: "Asia/Tokyo"
        },
        headers: {
          "Accept" => "application/json",
          "Content-Type" => "application/json; charset=utf-8"
        }
      })

      if response.success?
        data = response.parsed_response
        # 配列の場合は最初の要素を取得
        weather_data_source = data.is_a?(Array) ? data.first : data

        if weather_data_source && weather_data_source["current"]
          current_data = weather_data_source["current"]

          {
            temperature: current_data["temperature_2m"]&.to_f || 0.0,
            weather_code: current_data["weather_code"]&.to_i || 0,
            pressure: current_data["pressure_msl"]&.to_f || 0.0,
            humidity: current_data["relative_humidity_2m"]&.to_f || 0.0,
            recorded_at: current_data["time"]&.to_s || Time.current.to_s
          }
        else
          nil
        end
      else
        nil
      end
    rescue => e
      # 本番環境では必要に応じてエラーログを残す
      Rails.logger.error "Weather API Error: #{e.class} - #{e.message}" if Rails.env.production?
      nil
    end
  end
end
