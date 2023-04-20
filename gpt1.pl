dominoes(N, M, D) :- findall(D, domino(N, M, D), Ds), sort(Ds, D).

domino(N, M, D) :- 
  between(1, N, X), 
  between(1, M, Y), 
  between(1, N, X1), 
  between(1, M, Y1),
  domino(X, Y, X1, Y1, D).

domino(X, Y, X1, Y1, D) :- D = [[X, Y], [X1, Y1]], X1 is X + 1, Y1 is Y.
domino(X, Y, X1, Y1, D) :- D = [[X, Y], [X1, Y1]], X1 is X, Y1 is Y + 1.

solvePuzzle(Width, Height, Occupied) :-
  setof(D, (dominoes(Width, Height, D), \+ member(D, Occupied)), Dominoes),
  member(D1, Dominoes),
  member(D2, Dominoes),
  D1 \= D2,
  append([D1,D2], Occupied, AllOccupied),
  length(AllOccupied, TotalCells),
  TotalCells =:= Width * Height,
  print_board(Width, Height, AllOccupied),
  fail.

print_board(Width, Height, Occupied) :-
  between(1, Height, Y),
  nl,
  between(1, Width, X),
  (member([[X,Y], [X,Y+1]], Occupied) ; member([[X,Y+1], [X,Y]], Occupied)),
  write('[]'), !.

print_board(Width, Height, Occupied) :-
  between(1, Height, Y),
  nl,
  between(1, Width, X),
  (member([[X,Y], [X,Y+1]], Occupied) ; member([[X,Y+1], [X,Y]], Occupied)),
  write('[]').

print_board(_, _, _).
