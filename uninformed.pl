%% Get all possible dominoes for a given board size in a list
dominoes(Width, Height, Dominoes) :-
    findall(Domino, domino(Width, Height, Domino), Dominoes).

%% Get all possible dominoes for a given board size one by one
domino(Width, Height, Domino) :- 
  % Get all possible pairs of cells
  between(1, Width, Cell1X), 
  between(1, Height, Cell1Y), 
  between(1, Width, Cell2X), 
  between(1, Height, Cell2Y),

  % Only return the pairs that resemble a domino
  domino(Cell1X, Cell1Y, Cell2X, Cell2Y, Domino).


%% Domino rules (what makes two cells a domino)
domino(Cell1X, Cell1Y, Cell2X, Cell2Y, Domino) :- % Horizontal domino
    Domino = [[Cell1X, Cell1Y], [Cell2X, Cell2Y]], Cell2X is Cell1X + 1, Cell2Y is Cell1Y. 
domino(Cell1X, Cell1Y, Cell2X, Cell2Y, Domino) :- % Vertical domino
    Domino = [[Cell1X, Cell1Y], [Cell2X, Cell2Y]], Cell2X is Cell1X, Cell2Y is Cell1Y + 1. 

% Remove all dominoes that contain a given cell
removeOverlappingDominoes(Dominoes, Cell, RestDominoes) :-
    % For each domino, check if it contains the cell
    % If the cell is not part of the domino, keep the domino
    % If the cell is part of the domino, remove the domino
    exclude(member(Cell), Dominoes, RestDominoes).

% Collect all solutions in a list for Python to use
getAllSolutions(Width, Height, Bomb1X, Bomb1Y, Bomb2X, Bomb2Y, Solutions):-
    findall(Solution, solve(Width, Height, [Bomb1X, Bomb1Y], [Bomb2X, Bomb2Y], Solution), Solutions).

%%% Use this predicate %%%
%%% Usage: solve(3, 3, [1, 3], [2, 1], Solution). %%%
solve(Width, Height, Bomb1, Bomb2, Solution):-
    % First, get all possible dominoes for the given board size
    dominoes(Width, Height, AllDominoes), 
    % Remove the dominoes that overlap with the first bomb
    removeOverlappingDominoes(AllDominoes, Bomb1, AllDominoesNotOverlappingBomb1), 
    % And remove the dominoes that overlap with the second bomb
    removeOverlappingDominoes(AllDominoesNotOverlappingBomb1, Bomb2, AllDominoesNotOverlappingBomb1AndBomb2), 
    % Now we have all possible dominoes that do not overlap with the bombs
    AvailableMoves = AllDominoesNotOverlappingBomb1AndBomb2,
    % Find a solution by trying all possible dominoes while traversing the search tree
    findOneSolution(Width, Height, AvailableMoves, [], Solution).

% Traverse the search tree by trying all possible dominoes
findOneSolution(Width, Height, AvailableMoves, CurrentBoard, Solution):-
    % Get a domino from the list of available moves
    member([Cell1, Cell2], AvailableMoves),
    % Make sure the domino is not already in the board
    not(member([Cell1, Cell2], CurrentBoard)),
    % Add the domino to the board
    NewBoard = [[Cell1, Cell2] | CurrentBoard],
    % Remove the dominoes that overlap with the cells of the domino we just added
    removeOverlappingDominoes(AvailableMoves, Cell1, AvailableMovesNotOverlappingCell1),
    removeOverlappingDominoes(AvailableMovesNotOverlappingCell1, Cell2, AvailableMovesNotOverlappingCell1AndCell2),
    % Now we have a new list of available moves
    NewAvailableMoves = AvailableMovesNotOverlappingCell1AndCell2,
    (NewAvailableMoves = [] % If there are no more available moves, we have found a solution
    -> (Solution = NewBoard, true) % Return the solution and stop traversing the search tree by using 'true'
    ; findOneSolution(Width, Height, NewAvailableMoves, NewBoard, Solution)). % Otherwise, keep traversing the search tree

