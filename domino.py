def is_valid(board, i, j):
    if i < 0 or i >= len(board) or j < 0 or j >= len(board[0]):
        return False
    if board[i][j] == 1:
        return False
    if j + 1 < len(board[0]) and board[i][j+1] == 0:
        return True
    if i + 1 < len(board) and board[i+1][j] == 0:
        return True
    return False


def place_domino(board, count):
    if count == (len(board) * len(board[0])) // 2:
        return True
    for i in range(len(board)):
        for j in range(len(board[0])):
            if is_valid(board, i, j):
                if j + 1 < len(board[0]) and board[i][j+1] == 0:
                    board[i][j] = board[i][j+1] = 2
                    if place_domino(board, count+1):
                        return True
                    board[i][j] = board[i][j+1] = 0
                if i + 1 < len(board) and board[i+1][j] == 0:
                    board[i][j] = board[i+1][j] = 2
                    if place_domino(board, count+1):
                        return True
                    board[i][j] = board[i+1][j] = 0
    return False


board = [[1, 0, 0],
         [0, 0, 0],
         [0, 0, 1]]
if place_domino(board, 0):
    for row in board:
        print(row)
else:
    print("No solution found.")
