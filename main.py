import sys
import os
from window import View
from PyQt6.QtWidgets import QApplication
from controller import Controller

if __name__ == "__main__":
    app = QApplication(sys.argv)

    if len(sys.argv) < 2:
        print("Usage: python main.py <problem>")
        print("Please provide a problem to solve")
        sys.exit(1)

    problem = sys.argv[1]

    if not os.path.isfile(f"{problem}.pl"):
        print(f"File {problem}.pl does not exist")
        sys.exit(1)

    controller = Controller(problem)
    view = View(controller)

    app.exec()
