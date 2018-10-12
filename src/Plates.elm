module Plates exposing (Model, Msg(..), Plates, initialModel, update, view)

import Dict exposing (Dict)
import Html exposing (Attribute, Html, div, text)
import Html.Attributes exposing (class, style)
import Html.Events exposing (onClick)


type alias Plates =
    Dict Int String


type Msg
    = Select Int


type alias Model =
    { selected : Int
    }


default : Int
default =
    -1


initialModel : Model
initialModel =
    { selected = default
    }


update : Msg -> Model -> Model
update msg model =
    case msg of
        Select plate ->
            { model
                | selected =
                    if model.selected == plate then
                        default

                    else
                        plate
            }


plateStyle : Int -> Int -> Attribute Msg
plateStyle selected current =
    style "color"
        (if selected == current then
            "red"

         else
            "grey"
        )


viewPlates : Int -> Int -> String -> List (Html Msg) -> List (Html Msg)
viewPlates selected k v plates =
    div [ class "plate", plateStyle selected k, onClick (Select k) ] [ text v ] :: plates


view : Model -> Plates -> Html Msg
view model plates =
    div [ class "plates" ] (Dict.foldr (viewPlates model.selected) [] plates)
