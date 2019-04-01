class WatorSim {
    ArrayList<shark> sharks;
    ArrayList<fish> fish;
    final int FISH_BREED = 6;
    final int SHARK_BREED = 12;
    final int SHARK_STARVE = 8;
    color sharkColor = color(192,192,192); // silver
    color fishColor = color(255, 153, 153); // salmon
    color oceanColor = color(0,41,58); // ocean blue
    int nfish;
    int nsharks;
    CELL[][] grid;
    WatorSim(int nfish, int nsharks) {
        this.nfish = nfish;
        this.nsharks = nsharks;
        grid = new CELL[COLS][ROWS];
        fish = new ArrayList<fish>();
        sharks = new ArrayList<shark>();
        for (int i = 0; i < COLS; i++) {
          for (int j = 0; j < ROWS; j++) { 
            grid[i][j] = new CELL(i,j);
          }
        }
        int numAnimals = nfish+nsharks;
        int numCells = ROWS*COLS;
        int sharksRemainingToPlace = nsharks;
        int fishRemainingToPlace = nfish;

        for(int i = 0; i <numAnimals;i++) {
          int index = (int)map(i, 0, numAnimals, 0, numCells);
          int ax = index % COLS;
          int ay = index / COLS;
          float rand = random(1);
            if(rand>0.5) {
              if(fishRemainingToPlace > 0) {
                fish currFish = new fish(FISH_BREED, ax, ay);
                grid[ax][ay].addFish(currFish, CELL.eFISH);
                fish.add(currFish);
                fishRemainingToPlace--;
              } else {
                shark currShark = new shark(SHARK_BREED, SHARK_STARVE, ax, ay);
                grid[ax][ay].addFish(currShark, CELL.eSHARK);
                sharks.add(currShark);
                sharksRemainingToPlace--;
              }
            } else {
              if(sharksRemainingToPlace > 0) {
                shark currShark = new shark(SHARK_BREED, SHARK_STARVE, ax, ay);
                grid[ax][ay].addFish(currShark, CELL.eSHARK);
                sharks.add(currShark);
                sharksRemainingToPlace--;
              } else {
                fish currFish = new fish(FISH_BREED, ax, ay);
                grid[ax][ay].addFish(currFish, CELL.eFISH);
                fish.add(currFish);
                fishRemainingToPlace--;
              }
            } 
        }
    }

    //hack
    void cleanGrid() {
      for (int i = 0; i < COLS; i++) {
          for (int j = 0; j < ROWS; j++) {
            if(grid[i][j].sOccupied) {
              ((shark)grid[i][j].f).dies();
            } 
          }
      }
    }
    void draw() {
      for(int i = 0; i < sharks.size(); i++) {
        fill(sharkColor);
        sharks.get(i).draw();
        if(!bPaused) {
            sharks.get(i).update();
        }
      }
      for(int i = 0; i < fish.size(); i++) {
        fill(fishColor);
        fish.get(i).draw();
        if(!bPaused) {
            fish.get(i).update();
        }
      }
      if(!bPaused) {
        cleanGrid(); // hack TODO remove
      }
    }
}