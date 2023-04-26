from PyQt6.QtWidgets import QWidget, QLabel, QVBoxLayout
from PyQt6.QtGui import QPainter, QPixmap, QTransform
from PyQt6.QtCore import QRect, Qt
from solution import Solution
from board import Board

CELL_SIZE = 100


class SolutionWidget(QWidget):
    def __init__(self, board: Board, solution: Solution):
        super().__init__()
        self.setLayout(QVBoxLayout())

        self.label = QLabel(str(solution))
        canvas = QPixmap(
            board.height * CELL_SIZE + 10,
            board.width * CELL_SIZE + 10
        )
        canvas.fill(Qt.GlobalColor.white)
        self.label.setPixmap(canvas)

        self.layout().addWidget(self.label)
        canvas = self.label.pixmap()
        painter = QPainter(canvas)

        for bomb in board.bombs():
            bomb_pixmap = QPixmap('bomb.png')
            painter.drawPixmap(QRect(
                (bomb.y - 1) * CELL_SIZE + 5,
                (bomb.x - 1) * CELL_SIZE + 5,
                CELL_SIZE,
                CELL_SIZE,
            ), bomb_pixmap)

        for domino in solution.dominoes:
            # replace with the actual path of your image
            domino_pixmap = QPixmap('domino.png')
            if not domino.is_vertical():
                # rotate the pixmap by 90 degrees
                domino_pixmap = domino_pixmap.transformed(
                    QTransform().rotate(90))
            painter.drawPixmap(QRect(
                (domino.cell1.y - 1) * CELL_SIZE + 5,
                (domino.cell1.x - 1) * CELL_SIZE + 5,
                CELL_SIZE * 2 if domino.is_vertical() else CELL_SIZE,
                CELL_SIZE if domino.is_vertical() else CELL_SIZE * 2
            ), domino_pixmap)
        painter.end()
        self.label.setPixmap(canvas)
