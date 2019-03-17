import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)

-- Main

main = Browser.sandbox {init=init,update=update,view=view}

-- Model

type alias Model = {name:String,password:String,verifyPassword:String}

init:Model
init=Model "" "" ""

-- Update

type Msg = Name String | Password String | VerifyPassword String

update:Msg->Model->Model
update msg model=
    case msg of
        Name name->{model|name=name}
        Password password->{model|password=password}
        VerifyPassword password->{model|verifyPassword=password}

-- View

view : Model->Html Msg
view model =
    div []
    [
        viewInput "text" "Name" model.name Name,
        viewInput "password" "Password" model.password Password,
        viewInput "password" "Verify your password" model.verifyPassword VerifyPassword,
        viewValidation model
    ]

viewInput:String->String->String->(String -> msg)->Html msg
viewInput t p v handler =
    input [type_ t, placeholder p, value v, onInput handler] []

viewValidation model =
    if model.password==model.verifyPassword then
        div [style "color" "green"][text "OK"]
    else
        div [style "color" "red"][text "Passwords do not match!"]
