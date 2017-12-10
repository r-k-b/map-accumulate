module TestMapAccumulate exposing (suite)

import Expect exposing (Expectation, fail)
import Test exposing (describe, test, Test)
import MapAccumulate exposing (mapAccumL)
import Maybe.Extra


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
                        |> (\( list, acc ) -> ( list |> Maybe.Extra.values, acc ))
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
                        |> (\( list, acc ) -> ( list |> Maybe.Extra.values, acc ))
                        |> Expect.equal ( [ 2, 42, 5, 6, 7 ], "towel!" )
        ]
