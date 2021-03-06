module HomeHelper
  # https://stackoverflow.com/a/14457180
  # plus some magic values
  def laty(lat)
    width = 580
    height = 230
    lat_rad = lat * Math::PI / 180
    tan = Math.tan((Math::PI / 4) + (lat_rad / 2))
    mercator_n = Math.log(tan, Math::E)

    (height/2)-(width*mercator_n/(2*Math::PI))
  end

  # https://stackoverflow.com/a/14457180
  # plus some magic values
  def lngx(lng)
    width = 640.0
    ((lng + 180.0) * (width / 360.0)) - 99
  end

  # https://stackoverflow.com/a/31806074
  def arc(stop, next_stop)
    x1 = lngx(stop.lng)
    y1 = laty(stop.lat)
    x2 = lngx(next_stop.lng)
    y2 = laty(next_stop.lat)

    cx = (x1+x2) / 2
    cy = (y1+y2) / 2
    dx = (x2-x1) / 2
    dy = (y2-y1) / 2

    dd = Math.sqrt(dx*dx+dy*dy)
    ex = cx + dy/dd * 5
    ey = cy - dx/dd * 5

    %{
      <path
        d="m #{x1} #{y1} Q #{ex} #{ey} #{x2} #{y2}"
        fill="none"
        opacity="#{stop.to.future? ? 0.5 : 1}"
        stroke-dasharray="1,1"
        class="stroke-current text-accent stroke-1"
      />
    }
  end

  def stop_icon(stop)
    if stop.name == "Yosemite"
      return render('stop_icons/yosemite', stop: stop) if stop.from.future?

      link_to url_for(stop) do
        render 'stop_icons/yosemite_visited', stop: stop
      end
    elsif (stop.to.past? || stop.to.today?) && stop.from.past?
      link_to url_for(stop) do
        render 'stop_icons/visited', stop: stop
      end
    elsif stop.from.future?
      render 'stop_icons/future', stop: stop
    else
      yosemite = Stop.find_by(name: "Yosemite")
      link_to url_for(stop) do
        render 'stop_icons/today', stop: stop, flip: (yosemite.to.past? || yosemite.to.today?)
      end
    end
  end
end
