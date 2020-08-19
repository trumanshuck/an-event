module HomeHelper
  # https://stackoverflow.com/a/14457180
  # plus some magic values
  def laty(lat)
    width = 320
    height = 160
    lat_rad = lat * Math::PI / 180
    tan = Math.tan((Math::PI / 4) + (lat_rad / 2))
    mercator_n = Math.log(tan, Math::E)

    (height/2)-(width*mercator_n/(2*Math::PI))
  end

  # https://stackoverflow.com/a/14457180
  # plus some magic values
  def lngx(lng)
    width = 540.0
    ((lng + 180.0) * (width / 360.0)) - 74
  end
end
