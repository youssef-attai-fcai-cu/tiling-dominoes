% Define the board size and bomb locations
board_size(4, 5).
bomb(2, 2).
bomb(3, 4).

% Define the state of the board as a list of dominoes
initial_state([]).

% Define the possible orientations of a domino
orientation(h).
orientation(v).

% Define the possible moves (placing a domino in a position and orientation)
move(State, Move, NewState) :-
    board_size(M, N),
    % Generate all possible positions for a domino
    between(1, M, X),
    between(1, N, Y),
    % Check if the position is not a bomb cell
    \+ bomb(X, Y),
    % Generate all possible orientations for a domino
    member(O, [h, v]),
    % Check if the domino does not go out of bounds
    (O = h -> Y2 is Y + 1, Y2 =< N ; Y2 is Y, X2 is X + 1, X2 =< M),
    % Check if the position is not already occupied by another domino
    \+ member((X, Y, O), State),
    % Create the new state with the added domino
    append(State, [(X, Y, O)], NewState),
    % Check that the new state is valid (no overlapping dominoes)
    is_valid_state(NewState).

% Check if a state is valid (no overlapping dominoes)
is_valid_state(State) :-
    \+ (member((X, Y, _), State), member((X, Y, _), State)).

% Define the goal state (all squares covered)
goal_state(State) :-
    board_size(M, N),
    length(State, L),
    L =:= (M * N - 2) // 2.

% Define the search algorithm
search(State, _, _) :-
    goal_state(State),
    write('Solution: '), write(State), nl.

search(State, Visited, Depth) :-
    Depth > 0,
    move(State, _, NewState),
    \+ member(NewState, Visited),
    Depth2 is Depth - 1,
    search(NewState, [NewState | Visited], Depth2).

% Define the solve predicate
solve :-
    initial_state(State),
    search(State, [State], 100).
