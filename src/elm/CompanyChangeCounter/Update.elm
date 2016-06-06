module CompanyChangeCounter.Update where

import CompanyChangeCounter.Model as CompanyChangeCounter exposing (initialModel, Model)

import Debug

type Action
  = Count (Maybe Int)

update : Action -> Maybe Int
update action =
  case action of
    Count act ->
      let foo = Debug.log " action : "  action
      in
       Just (initialModel + 1)
