module ApplicationHelper
  def flash_background_color(type)
    case type.to_sym
    when :success then "bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded"
    when :danger  then "bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded"
    else "bg-gray-100 border border-gray-400 text-gray-700 px-4 py-3 rounded"
    end
  end
end
