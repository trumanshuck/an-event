module HomeHelper
  def laty(lat)
    northernmost = 49.384472
    southernmost = 24.446667
    map_offset = 8.5
    diff = northernmost - southernmost

    ((northernmost - lat) / diff * 100) + map_offset
  end

  def lngx(lng)
    easternmost = -66.949778.abs
    westernmost = -124.733056.abs
    diff = westernmost - easternmost

    (westernmost - lng.abs) / diff * 100
  end
end
