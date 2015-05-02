module ApplicationHelper

  # Returns the full title on a per-page basis
  def full_title(page_title = '')
    base_title = "Down Syndrome Assoc. of Brazos Valley"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end


  def calendar(date = Date.today, &block)
    Calendar.new(self, date, block).table
  end

end
