from PyQt6.QtWidgets import (
    QMainWindow,
    QHBoxLayout,
    QVBoxLayout,
    QLineEdit,
    QWidget,
    QPushButton,
    QScrollArea,
)

from PyQt6.QtCore import Qt
from bomb import Bomb
from board import Board
from solution_widget import SolutionWidget
from controller import Controller


class View(QMainWindow):
    def __init__(self, controller: Controller):
        super().__init__()
        self.controller = controller

        self.setWindowTitle("Tiling dominoes")

        self.container = QWidget()
        self.container.setLayout(QVBoxLayout())
        self.container.layout().setAlignment(Qt.AlignmentFlag.AlignTop)

        self.width_height_container = QWidget()
        self.width_height_container.setLayout(QHBoxLayout())

        self.width_lineedit = QLineEdit()
        self.width_lineedit.setPlaceholderText("Width")
        self.width_lineedit.returnPressed.connect(
            lambda: self.height_lineedit.setFocus())
        self.height_lineedit = QLineEdit()
        self.height_lineedit.setPlaceholderText("Height")
        self.height_lineedit.returnPressed.connect(
            lambda: self.bomb1_x_lineedit.setFocus())

        self.width_height_container.layout().addWidget(self.width_lineedit)
        self.width_height_container.layout().addWidget(self.height_lineedit)

        self.bomb_container = QWidget()
        self.bomb_container.setLayout(QHBoxLayout())

        self.bomb1_x_lineedit = QLineEdit()
        self.bomb1_x_lineedit.setPlaceholderText("Bomb 1 X")
        self.bomb1_x_lineedit.returnPressed.connect(
            lambda: self.bomb1_y_lineedit.setFocus())
        self.bomb1_y_lineedit = QLineEdit()
        self.bomb1_y_lineedit.setPlaceholderText("Bomb 1 Y")
        self.bomb1_y_lineedit.returnPressed.connect(
            lambda: self.bomb2_x_lineedit.setFocus())
        self.bomb2_x_lineedit = QLineEdit()
        self.bomb2_x_lineedit.setPlaceholderText("Bomb 2 X")
        self.bomb2_x_lineedit.returnPressed.connect(
            lambda: self.bomb2_y_lineedit.setFocus())
        self.bomb2_y_lineedit = QLineEdit()
        self.bomb2_y_lineedit.setPlaceholderText("Bomb 2 Y")
        self.bomb2_y_lineedit.returnPressed.connect(
            lambda: self.solve_button.click())

        self.bomb_container.layout().addWidget(self.bomb1_x_lineedit)
        self.bomb_container.layout().addWidget(self.bomb1_y_lineedit)
        self.bomb_container.layout().addWidget(self.bomb2_x_lineedit)
        self.bomb_container.layout().addWidget(self.bomb2_y_lineedit)

        self.solve_button = QPushButton("Solve")
        self.solve_button.clicked.connect(self.solve_clicked)

        self.result_scrollarea = QScrollArea()
        self.result_container = QWidget()
        self.result_container.setLayout(QVBoxLayout())
        self.result_container.layout().setAlignment(Qt.AlignmentFlag.AlignTop)
        self.result_scrollarea.setWidget(self.result_container)

        self.result_scrollarea.setVerticalScrollBarPolicy(
            Qt.ScrollBarPolicy.ScrollBarAlwaysOn)
        self.result_scrollarea.setHorizontalScrollBarPolicy(
            Qt.ScrollBarPolicy.ScrollBarAlwaysOff)
        self.result_scrollarea.setWidgetResizable(True)

        self.container.layout().addWidget(self.width_height_container)
        self.container.layout().addWidget(self.bomb_container)
        self.container.layout().addWidget(self.solve_button)
        self.container.layout().addWidget(self.result_scrollarea)

        self.setCentralWidget(self.container)
        self.show()

    def solve_clicked(self):
        for i in reversed(range(self.result_container.layout().count())):
            self.result_container.layout().itemAt(i).widget().setParent(None)
        try:
            # Get inputs
            width = int(self.width_lineedit.text())
            height = int(self.height_lineedit.text())
            bomb1_x = int(self.bomb1_x_lineedit.text())
            bomb1_y = int(self.bomb1_y_lineedit.text())
            bomb2_x = int(self.bomb2_x_lineedit.text())
            bomb2_y = int(self.bomb2_y_lineedit.text())
        except ValueError:
            print("Invalid input")
            return

        # Create the board
        board = Board(
            width, height,
            Bomb(bomb1_x, bomb1_y), Bomb(bomb2_x, bomb2_y)
        )

        # Call the controller
        solutions = self.controller.solve_puzzle(board)

        for solution in solutions:
            self.result_container.layout().addWidget(
                SolutionWidget(board, solution)
            )
