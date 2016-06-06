module EventCompanyFilter.Update where

import EventCompanyFilter.Model as EventCompanyFilter exposing (initialModel, Model)

import Company.Model as Company exposing (Model)

import CompanyChangeCounter.Update exposing (Action)



init : Model
init = initialModel

type Action
  = SelectCompany (Maybe Int)
  -- Child Action
   | ChildCompanyChangeCounterAction CompanyChangeCounter.Update.Action

type alias Model = EventCompanyFilter.Model

update : List Company.Model -> Action -> Model -> Model
update companies action model =
  case action of
    SelectCompany maybeCompanyId ->
      let
        isValidCompany val =
          companies
            |> List.filter (\company -> company.id == val)
            |> List.length


        eventCompanyFilter =
          case maybeCompanyId of
            Just val ->
              -- Make sure the given company ID is a valid one.
              if ((isValidCompany val) > 0)
                then Just val
                else Nothing
            Nothing ->
              Nothing
      in
        eventCompanyFilter
    ChildCompanyChangeCounterAction act->
      CompanyChangeCounter.Update.update act
