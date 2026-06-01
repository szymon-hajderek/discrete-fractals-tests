from lib.command import command, run

@command
def gen_n(): # Prints to stdout exactly the characters that are to be passed to the program as n.
  print("3", end='')

@command
def gen_stdin(): # Prints to stdout exactly the characters that are to be passed to the program as stdin.
  print("ABC")
  print("A" + "a" * 4094 + "x")
  print("B" + "b" * 4095 + "y")
  print("C" + "b" * 4095 + "z")
  print("x%")
  print("y&")
  print("z@")

if __name__ == "__main__":
  run()