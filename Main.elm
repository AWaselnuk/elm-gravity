import Color exposing (..)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import Mouse
import Window

-- MODEL

type alias Planet =
  Form

type alias Planets =
  List Form

type alias Coords =
  { w : Int, h : Int, x : Int, y : Int }

planets : Planets
planets =
  []

-- UPDATE

update : Coords -> Planets -> Planets
update coords planets =
  let
    (dx, dy) =
      (toFloat coords.x - toFloat coords.w / 2, toFloat coords.h / 2 - toFloat coords.y)
  in
    (planet 30.0 green (dx, dy)) :: planets

-- VIEW

view : (Int, Int) -> Planets -> Element
view (w, h) planets =
  collage w h planets

planet : Float -> Color -> (Float, Float) -> Planet
planet diameter color coords =
  circle diameter
    |> filled color
    |> move coords

-- SIGNALS

main : Signal Element
main =
  Signal.map2 view Window.dimensions (Signal.foldp update planets windowClickSignal)

clickSignal : Signal (Int, Int)
clickSignal =
  Signal.sampleOn Mouse.clicks Mouse.position

windowClickSignal : Signal Coords
windowClickSignal =
  Signal.map2 windowClickToCoords Window.dimensions clickSignal

windowClickToCoords : (Int, Int) -> (Int, Int) -> Coords
windowClickToCoords (w, h) (x, y) =
  { w = w, h = h, x = x, y = y }
