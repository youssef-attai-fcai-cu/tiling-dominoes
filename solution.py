from domino import Domino


class Solution:
    def __init__(self, solution: list) -> None:
        self.dominoes: list[Domino] = [
            Domino(domino) for domino in solution
        ]
