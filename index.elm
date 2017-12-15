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

type Msg = Change String | Add | Delete Int

update : Msg -> Model -> Model
update msg model =
    let
        isSpace = String.trim >> String.isEmpty
    in
        case msg of
            Add ->
                if isSpace model.newTodo then
                    model
                else
                    { model | todoList = model.newTodo :: model.todoList
                    , newTodo = "" }
            Change str ->
                { model | newTodo = str }
            Delete n ->
                let
                    t = model.todoList
                in          
                    { model |
                          todoList = List.take n t ++ List.drop (n + 1) t}

-- VIEW

view : Model -> Html Msg
view model =
    div []
        [ input [ type_ "text"
                , placeholder "input your todo"
                , onInput Change
                , value model.newTodo] []
        , button [ onClick (Add) ] [ text "add todo" ]
        , div [] (showList model.todoList)
         ]

showList : List String -> List (Html Msg)
showList =
    let
        todos = List.indexedMap (,)
        column (n,s) = div []
                   [ text s
                   , button[ onClick (Delete n) ] [ text "×" ]
                   ]
    in
        todos >> List.map column  
