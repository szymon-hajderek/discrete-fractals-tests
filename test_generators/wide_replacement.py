from lib.command import command, run

@command
def gen_n(): # Prints to stdout exactly the characters that are to be passed to the program as n.
  print("2", end='')

@command
def gen_stdin(): # Prints to stdout exactly the characters that are to be passed to the program as stdin.
  print("a")
  print("a" + "A" * 2500000000) 
  print("AB")

if __name__ == "__main__":
  run()