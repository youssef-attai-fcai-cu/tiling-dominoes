from bomb import Bomb


class Board:
    def __init__(self, width: int, height: int, bomb1: Bomb, bomb2: Bomb):
        self.width = width
        self.height = height
        self.bomb1 = bomb1
        self.bomb2 = bomb2

    def bombs(self):
        return [self.bomb1, self.bomb2]
