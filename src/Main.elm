module Main exposing (..)

import Html.Styled as Html exposing (Html, a, div, program, text, toUnstyled)
import Html.Styled.Attributes exposing (css, href)
import Navigation exposing (Location)
import Style exposing (..)
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

        Teams ->
            ( initialModel currentPage, Cmd.none )

        Units ->
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
        , Url.map Teams (Url.s "teams")
        , Url.map Units (Url.s "units")
        ]



-- MESSAGES


type Msg
    = NoOp
    | OnLocationChange Location


type Page
    = Home
    | Teams
    | Units
    | PageNotFound



-- VIEW


view : Model -> Html Msg
view model =
    case model.page of
        Home ->
            div []
                [ text "Home" ]

        Teams ->
            viewTeams

        Units ->
            div []
                [ text "Units" ]

        PageNotFound ->
            div []
                [ text "Page Not Found" ]


viewTeams : Html Msg
viewTeams =
    div [ css [ Style.teamsContainer ] ]
        [ div [] [ text "teams" ]
        , a [ href "/teams/highelf" ] [ text "highelf" ]
        , a [ href "/teams/orc" ] [ text "orc" ]
        ]



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
        , view = view >> toUnstyled
        , update = update
        , subscriptions = subscriptions
        }
