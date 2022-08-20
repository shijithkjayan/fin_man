defmodule SanchayikaWeb.ClassView do
  use SanchayikaWeb, :view
  alias SanchayikaWeb.ClassView

  def render("index.json", %{class: class}) do
    %{data: render_many(class, ClassView, "class.json")}
  end

  def render("show.json", %{class: class}) do
    %{data: render_one(class, ClassView, "class.json")}
  end

  def render("class.json", %{class: class}) do
    %{
      id: class.id,
      class_name: class.class_name
    }
  end
end
