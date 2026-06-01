from lib.command import command, run

@command
def gen_n(): # Prints to stdout exactly the characters that are to be passed to the program as n.
  print("100", end='')

@command
def gen_stdin(): # Prints to stdout exactly the characters that are to be passed to the program as stdin.
  print("abc")
  print("ab")
  print("bc")
  print("ca")

if __name__ == "__main__":
  run()