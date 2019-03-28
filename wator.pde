int cellDimm = 2;
int cellDimmMax;
int COLS, ROWS;
int szDimm;

class cell {
    boolean fOccupied = false , sOccupied = false;
}

class wator {
    ArrayList<shark> sharks;
    ArrayList<fish> fish;
    int nfish;
    int nsharks;
    cell[][] grid;
    wator(int nfish, int nsharks) {
        this.nfish = nfish;
        this.nsharks = nsharks;
        grid = new cell[COLS][ROWS];
        for (int i = 0; i < COLS; i++) {
          for (int j = 0; j < ROWS; j++) { 
            grid[i][j] = new cell();
          }
        }

        fish = new ArrayList<fish>();
        sharks = new ArrayList<shark>();
        for(int i = 0; i < nfish;i++) {
        }

        for(int i = 0; i < nsharks;i++) {
            
        }
    }
}