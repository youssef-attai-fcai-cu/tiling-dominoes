% Given a board N x M, find all possible combinations of domino pieces that can be placed on the board.

% The domino pieces are 2x1, and can be rotated.

% The board is a grid of squares, and the domino pieces can be placed on the squares.

% The domino pieces can be placed on the squares in any orientation.

dominoes(N, M, D) :- findall(D, domino(N, M, D), Ds), sort(Ds, D).

domino(N, M, D) :- 
  between(1, N, X), 
  between(1, M, Y), 
  between(1, N, X1), 
  between(1, M, Y1),
  domino(X, Y, X1, Y1, D).

domino(X, Y, X1, Y1, D) :- D = [[X, Y], [X1, Y1]], X1 is X + 1, Y1 is Y.
domino(X, Y, X1, Y1, D) :- D = [[X, Y], [X1, Y1]], X1 is X, Y1 is Y + 1.

% solvePuzzle(Width, Height, Occupied):-
%   domino(Width, Height, [Cell1, Cell2]),
%   \+member(Cell1, Occupied),
%   \+member(Cell2, Occupied),
%   writeln([Cell1, Cell2]),
%   solvePuzzle(Width, Height, [Cell1, Cell2|Occupied]).
% solvePuzzle(Width, Height, _):-
%   \+domino(Width, Height, [_,_]),
%   writeln(true),
%   fail.

% solvePuzzle(Width, Height, Occupied):-
%   once((domino(Width, Height, [Cell1, Cell2]),
%          \+member(Cell1, Occupied),
%          \+member(Cell2, Occupied),
%          writeln([Cell1, Cell2]),
%          solvePuzzle(Width, Height, [Cell1, Cell2|Occupied]))).
% solvePuzzle(_, _, _).

filterDominoes(Ds, Cell, FilteredDs) :-
  exclude(containsCell(Cell), Ds, FilteredDs).

containsCell(Cell, Domino) :-
  member(Cell, Domino).

% solvePuzzle(Width, Height, Occupied):-
%   domino(Width, Height, [Cell1, Cell2]),
%   not(member(Cell1, Occupied)),
%   not(member(Cell2, Occupied)),
%   write([Cell1, Cell2]), nl,
%   solvePuzzle(Width, Height, [Cell1, Cell2|Occupied]).

solvePuzzle(Width, Height):-
  dominoes(Width, Height, Available),
  solvePuzzle(Width, Height, Available).

solvePuzzle(Width, Height, Available):-
  domino(Width, Height, [Cell1, Cell2]),
  member([Cell1, Cell2], Available),
  write([Cell1, Cell2]), nl,
  filterDominoes(Available, Cell1, FilteredAvailable1),
  filterDominoes(FilteredAvailable1, Cell2, FilteredAvailable2),
  (FilteredAvailable2 = [] -> true; solvePuzzle(Width, Height, FilteredAvailable2)).
% solvePuzzle(_, _, _).

