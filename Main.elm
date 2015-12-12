import Color exposing (..)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import Mouse
import Window

-- MODEL

-- TODO: Turn model into list of Graphics forms that represent planets
type alias Planet =
  (Int, Int)

type alias Model =
  List (Int, Int)

planets : Model
planets =
  [(50, 50)]

-- UPDATE

update : (Int, Int) -> Model -> Model
update mousePos planets =
  mousePos :: planets

-- VIEW

view : (Int, Int) -> List (Int, Int) -> Element
view (w, h) planets =
  let
    (x, y) =
      Maybe.withDefault (0, 0) (List.head planets)
    (dx, dy) =
      (toFloat x - toFloat w / 2, toFloat h / 2 - toFloat y)
    diameter =
      30
  in
    collage w h
      [ circle diameter
          |> filled red
          |> move (dx, dy)
      ]

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
