defmodule SanchayikaWeb.YearView do
  use SanchayikaWeb, :view
  alias SanchayikaWeb.YearView

  def render("index.json", %{year: year}) do
    %{data: render_many(year, YearView, "year.json")}
  end

  def render("show.json", %{year: year}) do
    %{data: render_one(year, YearView, "year.json")}
  end

  def render("year.json", %{year: year}) do
    %{
      id: year.id,
      start_year: year.start_year,
      end_year: year.end_year
    }
  end
end
