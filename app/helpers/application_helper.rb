module ApplicationHelper
  def romanian_format(date)
    begin
      date.strftime("%d %B %Y")
    rescue
      ""
    end
  end
end
