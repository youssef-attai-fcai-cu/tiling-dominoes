dominoes(N, M, D) :- findall(D, domino(N, M, D), Ds), sort(Ds, D).

domino(N, M, D) :- 
  between(1, N, X), 
  between(1, M, Y), 
  between(1, N, X1), 
  between(1, M, Y1),
  domino(X, Y, X1, Y1, D).

domino(X, Y, X1, Y1, D) :- D = [[X, Y], [X1, Y1]], X1 is X + 1, Y1 is Y.
domino(X, Y, X1, Y1, D) :- D = [[X, Y], [X1, Y1]], X1 is X, Y1 is Y + 1.

filterDominoes(Ds, Cell, FilteredDs) :-
  exclude(containsCell(Cell), Ds, FilteredDs).

containsCell(Cell, Domino) :-
  member(Cell, Domino).

solvePuzzle(Width, Height, Bomb1X, Bomb1Y, Bomb2X, Bomb2Y):-
  dominoes(Width, Height, Available),
  Bomb1 = [Bomb1X, Bomb1Y],
  Bomb2 = [Bomb2X, Bomb2Y],
  filterDominoes(Available, Bomb1, FilteredAvailable1),
  filterDominoes(FilteredAvailable1, Bomb2, FilteredAvailable2),
  solvePuzzle(Width, Height, FilteredAvailable2, []).

solvePuzzle(Width, Height, Available, Board):-
  domino(Width, Height, [Cell1, Cell2]),
  member([Cell1, Cell2], Available),
  not(member([Cell1, Cell2], Board)),
  NewBoard = [[Cell1, Cell2] | Board],
  filterDominoes(Available, Cell1, FilteredAvailable1),
  filterDominoes(FilteredAvailable1, Cell2, FilteredAvailable2),
  (FilteredAvailable2 = [] -> (write(NewBoard), true); solvePuzzle(Width, Height, FilteredAvailable2, NewBoard)).

