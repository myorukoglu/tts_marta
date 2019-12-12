module ApplicationHelper
  def nearby(lng1, lat1, lng2, lat2)
    (lng1-lng2).abs <= 0.05 && (lat1-lat2).abs <= 0.05
  end

  def valid_location(location)
    location.latitude != nil && location.longitude != nil
  end	
end
