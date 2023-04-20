from pyswip import Prolog


class Bomb:
    def __init__(self, x, y):
        self.x = x
        self.y = y


prolog = Prolog()

# Load your Prolog program
prolog.consult('uninformed.pl')

def solve_puzzle(width, height, bomb1, bomb2):
    # Call the Prolog predicate
    result = prolog.query(
        f"getAllSolutions({width}, {height}, {bomb1.x}, {bomb1.y}, {bomb2.x}, {bomb2.y}, Solutions)."
    )
    return list(result)[0]


result = solve_puzzle(3, 3, Bomb(1, 3), Bomb(2, 1))
solutions = result['Solutions']
for solution in solutions:
    print(solution)
