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

planets : Planets
planets =
  []

-- UPDATE

-- TODO: Set proper coords
update : (Int, Int) -> Planets -> Planets
update mousePos planets =
  let
    (x, y) = (toFloat (fst mousePos), toFloat (snd mousePos))
  in
    (planet 30.0 red (x, y)) :: planets

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
  Signal.map2 view Window.dimensions (Signal.foldp update planets clickSignal)

clickSignal : Signal (Int, Int)
clickSignal =
  Signal.sampleOn Mouse.clicks Mouse.position

clickCount : Signal Int
clickCount =
  Signal.foldp (\click total -> total + 1) 0 Mouse.clicks
