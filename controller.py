from pyswip import Prolog
from solution import Solution
from board import Board


class Controller:
    def __init__(self, problem: str):
        self.prolog = Prolog()
        self.prolog.consult(f"{problem}.pl")

    def solve_puzzle(self, board: Board):
        result = self.prolog.query(
            "getAllSolutions("
            f"{board.width}, {board.height}, "
            f"{board.bomb1.x}, {board.bomb1.y}, "
            f"{board.bomb2.x}, {board.bomb2.y}, "
            "Solutions)."
        )

        solutions = list(result)[0]["Solutions"]
        return [Solution(solution) for solution in solutions]
