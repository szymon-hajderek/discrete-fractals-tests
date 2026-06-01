from lib.command import command, run

@command
def gen_n():
  print("32", end='')

@command
def gen_stdin():
  print("a")
  print("aaa")

if __name__ == "__main__":
  run()