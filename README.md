# Game_of_Life_RISCV

  Conway's game of life's rules and details are explained in 
  [this wikipedia article](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life). 
  To play (watch) the game develop, open the `src` folder in terminal 
  and run the command 
  ```
  ./fpgrars-x86_64-unknown-linux-gnu--8-bit-display GameOfLife.asm
  ```
  The game will then unravel in a new window, 
  starting from the initial state pointed by the `.data` file 
  in the `initial_configuration` folder.
  Check out fpgrars [from the source!](https://github.com/LeoRiether/FPGRARS)
  
  > Please note that this will only work on Linux, 
  > and make sure the `fpgrars` executable was granted permission to run.
