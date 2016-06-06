module CompanyChangeCounter.View where

import CompanyChangeCounter.Model exposing (initialModel, Model)
import CompanyChangeCounter.Update exposing (Action)



import Html exposing (h3, a, i, div, input, text, select, span, li, option, ul, Html)
import Html.Attributes exposing (class, hidden, href, id, placeholder, selected, style, value)
import Html.Events exposing (on, onClick, targetValue)




view model =
  span [ class "companies"] [toString model |> (\n -> "Times Changed: " ++ n) |> text ]
