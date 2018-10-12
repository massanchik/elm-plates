module Main exposing (main)

import Browser
import Dict exposing (Dict)
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Plates as P


type Msg
    = PMsg P.Msg


type alias Model =
    { plates : P.Model
    , choises : P.Plates
    }


main : Program () Model Msg
main =
    Browser.sandbox { init = initialModel, update = update, view = view }


initialModel : Model
initialModel =
    { plates = P.initialModel
    , choises =
        Dict.fromList
            [ ( 0, "First" )
            , ( 1, "Second" )
            , ( 2, "Third" )
            ]
    }


update : Msg -> Model -> Model
update msg model =
    case msg of
        PMsg pMsg ->
            { model | plates = P.update pMsg model.plates }


view : Model -> Html Msg
view model =
    div []
        [ Html.map PMsg (P.view model.plates model.choises)
        ]
