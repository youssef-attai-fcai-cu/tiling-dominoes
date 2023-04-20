replace(0, [_|T], X, [X|T]).
replace(I, [H|T], X, [H|R]) :-
  I > 0,
  I1 is I-1,
  replace(I1, T, X, R).

place_domino(Board, I, J, I1, J1, NewBoard) :-
  nth0(I, Board, Row), % Row is the Ith row of the board
  nth0(J, Row, Element), % Element is the Jth element of the row
  Element = 0, % Element is empty
  nth0(I1, Board, Row1), % Row1 is the I1th row of the board
  nth0(J1, Row1, Element1), % Element1 is the J1th element of the row
  Element1 = 0, % Element1 is empty
  % Replace the two cells with 2
  replace(J, Row, 2, NewRow),
  replace(J1, NewRow, 2, NewRow1),
  replace(I, Board, NewRow1, NewBoard).
  

dominoes(Width, Height, Board):-
  W is Width - 1,
  H is Height - 1,
  between(0, W, I), % I is the row number
  between(0, H, J), % J is the column number
  nth0(I, Board, Row), % Row is the Ith row of the board
  nth0(J, Row, Element), % Element is the Jth element of the row
  Element = 0, % Element is empty
  J1 is J+1, % J1 is the column number of the domino to the right
  J1 < Width, % J1 is within the board
  nth0(J1, Row, Element1), % Element1 is the J1th element of the row
  Element1 = 0, % Element1 is empty
  % Recurse with the two cells = 2 instead of 0 (i.e. place the domino)
  % and the rest of the board is the same
  place_domino(Board, I, J, I, J1, NewBoard),
  % If I reaches W and J reaches H, then the board is full so we write the NewBoard
  (I = W, J = H -> write(NewBoard) ; true),
  dominoes(Width, Height, NewBoard).

dominoes(Width, Height, Board):-
  W is Width - 1,
  H is Height - 1,
  between(0, W, I), % I is the row number
  between(0, H, J), % J is the column number
  nth0(I, Board, Row), % Row is the Ith row of the board
  nth0(J, Row, Element), % Element is the Jth element of the row
  Element = 0, % Element is empty
  I1 is I+1, % J1 is the column number of the domino to the right
  I1 < Height, % J1 is within the board
  nth0(I1, J, Element1), % Element1 is the J1th element of the row
  Element1 = 0, % Element1 is empty
  % Recurse with the two cells = 2 instead of 0 (i.e. place the domino)
  % and the rest of the board is the same
  place_domino(Board, I, J, I1, J, NewBoard),
  % If I reaches W and J reaches H, then the board is full so we write the NewBoard
  (I = W, J = H -> write(NewBoard) ; true),
  dominoes(Width, Height, NewBoard).
)
