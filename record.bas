DECLARE INTEGER CONSTANT True = 1
DECLARE INTEGER CONSTANT False = 0

! This record can hold the state of a game
RECORD GameStateType
    LONG landed	! Set to 1 when landed
    LONG restart	! pilot has requested game reset
    LONG quit
    LONG st 		! Step counter
    LONG ts
    LONG score		! The final score, if eligible for one!
END RECORD GameStateType

! Variable defining the state of the game
DECLARE GameStateType GameState

