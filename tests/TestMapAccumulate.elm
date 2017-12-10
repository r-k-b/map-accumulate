module TestMapAccumulate exposing (suite)

import Expect exposing (Expectation, fail)
import Test exposing (describe, test, Test)
import MapAccumulate exposing (mapAccumL)


suite =
    describe "main"
        [ test "basic example" <|
            let
                func : Int -> String -> ( Int, String )
                func b a =
                    if b % 2 == 0 then
                        -- even
                        ( b, a )
                    else
                        -- odd
                        ( b, a ++ "," ++ toString b )
            in
                \_ ->
                    mapAccumL func "" [ 1, 2, 3, 4 ]
                        |> Expect.equal ( [ 2, 4 ], ",1,3" )
        ]
