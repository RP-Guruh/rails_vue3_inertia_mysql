class HomeController < ApplicationController
  def index
    waktu = Time.now.strftime("%H:%M:%S")
    render inertia: "Index", props: { time_now: waktu }
  end
end
