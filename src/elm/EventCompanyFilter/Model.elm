module EventCompanyFilter.Model where

import CompanyChangeCounter.Model as CompanyChangeCounter exposing (initialModel, Model)

type alias Model =
  { eventCompanyFilter : Maybe Int
  , companyChangeCounter : CompanyChangeCounter.Model
  }

initialModel : Model
initialModel =
  { eventCompanyFilter = Nothing
  , companyChangeCounter = CompanyChangeCounter.initialModel
  }
