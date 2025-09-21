module ApplicationHelper
  def flash_background_color(type)
    case type.to_sym
    when :success then "bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded"
    when :danger  then "bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded"
    else "bg-gray-100 border border-gray-400 text-gray-700 px-4 py-3 rounded"
    end
  end

  def weather_code_to_japanese(code)
    case code = code.to_i
    when 0
      "☀️ 快晴"
    when 1
      "🌤️ 晴れ"
    when 2
      "⛅ 一部曇り"
    when 3
      "☁️ 曇り"
    when 45, 48
      "🌫️ 霧"
    when 51, 53, 55
      "🌦️ 霧雨"
    when 56, 57, 66, 67
      "🧊 凍雨"
    when 61, 63, 65
      "🌧️ 雨"
    when 71, 73, 75, 77
      "❄️ 雪"
    when 80, 81, 82
      "🌦️ にわか雨"
    when 85, 86
      "🌨️ にわか雪"
    when 95, 96, 99
      "⛈️ 雷雨"
    else
      "❓ 不明"
    end
  end
end
