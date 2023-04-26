from cell import Cell


class Domino:
    def __init__(self, domino: list) -> None:
        self.cell1 = Cell(domino[0])
        self.cell2 = Cell(domino[1])

    def is_vertical(self) -> bool:
        return self.cell1.x == self.cell2.x
