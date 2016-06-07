module EventCompanyFilter.View where

import EventCompanyFilter.Model as EventCompanyFilter exposing (initialModel, Model)
import EventCompanyFilter.Update exposing (Action)

import CompanyChangeCounter.View exposing (view)
import CompanyChangeCounter.Model exposing (Model)
import CompanyChangeCounter.Update exposing (Action)

import Company.Model as Company exposing (Model)
import Html exposing (h3, a, i, div, input, text, select, span, li, option, ul, Html)
import Html.Attributes exposing (class, hidden, href, id, placeholder, selected, style, value)
import Html.Events exposing (on, onClick, targetValue)
import String exposing (toInt)
import Json.Decode as Json

import Debug

type alias Model = EventCompanyFilter.Model

view : List Company.Model -> Signal.Address EventCompanyFilter.Update.Action -> Model -> Html
view companies address model =
  div
    [ class "wrapper -suffix" ]
    [ h3
        [ class "title" ]
        [ i [ class "fa fa-briefcase" ] []
        , text <| " " ++ "Companies"
        ]
    , companyListForSelect address companies model
    ]

companyListForSelect : Signal.Address EventCompanyFilter.Update.Action -> List Company.Model -> Model -> Html
companyListForSelect address companies model  =
  let
    selectedText =
      case model.eventCompanyFilter of
        Just id -> toString id
        Nothing -> ""

    textToMaybe string =
      if string == "0"
        then Nothing
        else
          -- Converting to int return a result.
          case (String.toInt string) of
            Ok val ->
              Just val
            Err _ ->
              Nothing


    -- Add an "All companies" option
    companies' =
      (Company.Model 0 "-- All companies --") :: companies

    -- The selected company ID.
    selectedId =
      case model.eventCompanyFilter of
        Just id ->
          id
        Nothing ->
          0

    getOption company =
      option [value <| toString company.id, selected (company.id == selectedId)] [ text company.label]
  in
    div [] [ select [ class "companies"
                    , value selectedText
                    , on "change" targetValue (\str -> Signal.message address <| EventCompanyFilter.Update.SelectCompany <| textToMaybe str )

                    , onChange address ( EventCompanyFilter.Update.ChildCompanyChangeCounterAction ( CompanyChangeCounter.Update.Count (textToMaybe "1") ) )

                    ]
             (List.map getOption companies')
             , div [] [ (CompanyChangeCounter.View.view model.companyChangeCounter) ]
      ]


onChange address val =
  on "change" Json.value (\_ -> Signal.message address val)
