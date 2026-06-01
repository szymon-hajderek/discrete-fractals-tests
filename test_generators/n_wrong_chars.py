from lib.command import command, run

@command
def gen_n(): # Prints to stdout exactly the characters that are to be passed to the program as n.
  print("123 xd", end='')

@command
def gen_stdin(): # Prints to stdout exactly the characters that are to be passed to the program as stdin.
  print("c" + "a" * 1000000000) # Program should never have to read this data.

if __name__ == "__main__":
  run()