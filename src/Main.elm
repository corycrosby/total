module Main exposing (..)

import Html exposing (Html, div, program, text)
import Navigation exposing (Location)
import UrlParser as Url exposing ((</>), parsePath, top)


-- MODEL


type alias Model =
    { page : Page }


initialModel : Page -> Model
initialModel page =
    { page = page }


init : Location -> ( Model, Cmd Msg )
init location =
    let
        currentPage =
            parseLocation location
    in
    case currentPage of
        Home ->
            ( initialModel currentPage, Cmd.none )

        PageNotFound ->
            ( initialModel currentPage, Cmd.none )


parseLocation : Navigation.Location -> Page
parseLocation location =
    case parsePath parseUrl location of
        Just route ->
            route

        Nothing ->
            PageNotFound


parseUrl : Url.Parser (Page -> a) a
parseUrl =
    Url.oneOf
        [ Url.map Home top
        ]



-- MESSAGES


type Msg
    = NoOp
    | OnLocationChange Location


type Page
    = Home
    | PageNotFound



-- VIEW


view : Model -> Html Msg
view model =
    case model.page of
        Home ->
            div []
                [ text "Home" ]

        PageNotFound ->
            div []
                [ text "Page Not Found" ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnLocationChange location ->
            init location

        NoOp ->
            ( model, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- MAIN


main : Program Never Model Msg
main =
    Navigation.program OnLocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
