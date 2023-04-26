dominoes(N, M, D) :- findall(D, domino(N, M, D), Ds), sort(Ds, D).

domino(N, M, D) :- 
  % Get all possible pairs of cells
  between(1, N, X), 
  between(1, M, Y), 
  between(1, N, X1), 
  between(1, M, Y1),
  % Only return the pairs that resembles a domino
  domino(X, Y, X1, Y1, D).

domino(X, Y, X1, Y1, D) :- D = [[X, Y], [X1, Y1]], X1 is X + 1, Y1 is Y. % Adjacent horizontally
domino(X, Y, X1, Y1, D) :- D = [[X, Y], [X1, Y1]], X1 is X, Y1 is Y + 1. % Adjacent vertically

filterDominoes(Ds, Cell, FilteredDs) :-
  exclude(containsCell(Cell), Ds, FilteredDs).

containsCell(Cell, Domino) :-
  member(Cell, Domino).

getAllSolutions(Width, Height, Bomb1X, Bomb1Y, Bomb2X, Bomb2Y, Solutions):-
  findall(Solution, solvePuzzle(Width, Height, Bomb1X, Bomb1Y, Bomb2X, Bomb2Y, Solution), Solutions).

% Use this
solvePuzzle(Width, Height, Bomb1X, Bomb1Y, Bomb2X, Bomb2Y, Solution):-
  dominoes(Width, Height, Available),
  Bomb1 = [Bomb1X, Bomb1Y],
  Bomb2 = [Bomb2X, Bomb2Y],
  filterDominoes(Available, Bomb1, FilteredAvailable1),
  filterDominoes(FilteredAvailable1, Bomb2, FilteredAvailable2),
  solvePuzzle(Width, Height, FilteredAvailable2, [], Solution).

solvePuzzle(Width, Height, Available, Board, Solution):-
  domino(Width, Height, [Cell1, Cell2]),
  member([Cell1, Cell2], Available),
  not(member([Cell1, Cell2], Board)),
  % nl, write("Domino: "), write([Cell1, Cell2]), nl,
  % write("Board: "), write(Board), nl,
  NewBoard = [[Cell1, Cell2] | Board],
  filterDominoes(Available, Cell1, FilteredAvailable1),
  filterDominoes(FilteredAvailable1, Cell2, FilteredAvailable2),
  % Number of pieces on the board + Number of moves can be played >= Number of empty cells (initially) / 2
  length(NewBoard, NumPiecesOnBoard),
  length(FilteredAvailable2, NumMovesCanBePlayed),
  NumEmptyCells is (Width * Height) - 2,
  floor((NumEmptyCells / 2), F),
  NumPiecesOnBoard + NumMovesCanBePlayed >= F,
  % write("NewBoard: "), write(NewBoard), nl,
  (
    FilteredAvailable2 = [] % condition
    -> % If the condition is true, then do this
      (Solution = NewBoard, true)
    ; % otherwise do this
    solvePuzzle(Width, Height, FilteredAvailable2, NewBoard, Solution)
  ).

