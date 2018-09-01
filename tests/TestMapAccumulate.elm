module TestMapAccumulate exposing (suite)

import Expect exposing (Expectation, fail)
import Test exposing (describe, test, Test)
import MapAccumulate exposing (mapAccumL)


suite =
    describe "main"
        [ test "example 1" <|
            let
                func : Int -> String -> ( Int, String )
                func b a =
                    if b % 2 == 0 then
                        -- even
                        ( b, a )
                    else
                        -- odd
                        ( b * 10, a ++ "," ++ toString b )
            in
                \_ ->
                    mapAccumL func "" [ 1, 2, 3, 4 ]
                        |> Expect.equal ( [ 10, 2, 30, 4 ], ",1,3" )
        , test "example 2 - removal" <|
            let
                func : Int -> String -> ( Maybe Int, String )
                func b a =
                    if b % 2 == 0 then
                        -- even
                        ( Just b, a )
                    else
                        -- odd
                        ( Nothing, a ++ "," ++ toString b )
            in
                \_ ->
                    mapAccumL func "" [ 1, 2, 3, 4 ]
                        |> (\( list, acc ) -> ( list |> values, acc ))
                        |> Expect.equal ( [ 2, 4 ], ",1,3" )
        , test "example 3 - removal with clearing" <|
            let
                func : Int -> String -> ( Maybe Int, String )
                func b a =
                    if a == "towel!" then
                        ( Just b, a )
                    else if b == 42 then
                        ( Just b, "towel!" )
                    else if b % 2 == 0 then
                        -- even
                        ( Just b, a )
                    else
                        -- odd
                        ( Nothing, a ++ "," ++ toString b )
            in
                \_ ->
                    mapAccumL func "" [ 1, 2, 3, 42, 5, 6, 7 ]
                        |> (\( list, acc ) -> ( list |> values, acc ))
                        |> Expect.equal ( [ 2, 42, 5, 6, 7 ], "towel!" )
        ]


{-| Convert a list of `Maybe a` to a list of `a` only for the values different
from `Nothing`.

    values [ Just 1, Nothing, Just 2 ] == [1, 2]

-}
values : List (Maybe a) -> List a
values =
    List.foldr foldrValues []


foldrValues : Maybe a -> List a -> List a
foldrValues item list =
    case item of
        Nothing ->
            list

        Just v ->
            v :: list
