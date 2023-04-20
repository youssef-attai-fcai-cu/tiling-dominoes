% Uninformed search
search(CurrentState, GoalState, Visited):-
    CurrentState = GoalState, !,
    write('Goal state reached'), nl,
    write('Visited: '), write(Visited), nl.

search(CurrentState, GoalState, Visited):-
    step(CurrentState, NextState),
    not(member(NextState, Visited)),
    isOkay(NextState),
    append(Visited, [CurrentState], NewVisited),
    search(NextState, GoalState, NewVisited).

% Here are all the steps that can be taken
step([dirty, Y, 1], [clean, Y, 1]). % clean tile1 if on tile1 and tile1 is dirty
step([X, dirty, 2], [X, clean, 2]). % clean tile2 if on tile2 and tile2 is dirty
step([X, Y, 1], [X, Y, 2]). % move from tile1 to tile2
step([X, Y, 2], [X, Y, 1]). % move from tile2 to tile1

isOkay(_):- true.