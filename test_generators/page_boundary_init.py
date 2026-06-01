from lib.command import command, run

@command
def gen_n(): # Prints to stdout exactly the characters that are to be passed to the program as n.
  print("3", end='')

@command
def gen_stdin(): # Prints to stdout exactly the characters that are to be passed to the program as stdin.
  print("a" * 4096 + "b")
  print("aA")
  print("bB")

if __name__ == "__main__":
  run()