module AdminHelper
  def graph_data(exposable_type,exposures)
    
    if (DateTime.now.to_date - exposable_type.created_at.to_date).to_i < 14  
      dates = *(exposable_type.created_at.to_date..(exposable_type.created_at.to_date + 14.days))
    else 
      dates = *((DateTime.now.to_date - 14.days)..(DateTime.now.to_date))
    end
    
    lines = nil
    dates.each do |date|
      lines = lines.to_s + "['#{date}', #{exposures[date] != nil ? exposures[date].count : '0'}], \n"
    end
    
    raw lines
	end
end