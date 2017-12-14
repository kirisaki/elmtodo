import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)


main =
  Html.beginnerProgram { model = model, view = view, update = update }


-- MODEL

type alias Model =
    { newTodo : String
    , todoList : List String
    }

model : Model
model = { newTodo = ""
        , todoList = []
        }
              
    

-- UPDATE

type Msg = Change String | Add

update : Msg -> Model -> Model
update msg model =
    case msg of
        Add ->
            { model | todoList = model.newTodo :: model.todoList
            , newTodo = "" }
        Change str ->
            { model | newTodo = str }

-- VIEW

view : Model -> Html Msg
view model =
    div []
        [ input [ type_ "text", placeholder "input your todo", onInput Change ] []
        , button [ onClick (Add) ] [ text "add todo" ]
        , div [] (showList model)
         ]

showList : Model -> List (Html Msg)
showList sl =
    let
        column s = div []
                   [ text s
                  -- , button[ onClick Delete ] [ text "×" ]
                   ]
    in
        List.map column sl.todoList
