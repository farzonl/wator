int cellDimm = 2;
int cellDimmMax;
int COLS, ROWS;
int szDimm;
Boolean bResize = false;

class cell {
    boolean fOccupied = false , sOccupied = false;
}

class wator {
    ArrayList<shark> sharks;
    ArrayList<fish> fish;
    final int FISH_BREED = 6;
    final int SHARK_BREED = 8;
    final int SHARK_STARVE = 12;
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
wator watorWorld;

void setup() {
  szDimm = 600;
  size(600, 600);
  updateCellDimm();
}

void updateCellDimm() {
  cellDimmMax = szDimm/10;
  if(cellDimm > cellDimmMax) {
    cellDimm = cellDimmMax;
  }

  COLS = width /cellDimm;
  ROWS = height/cellDimm;
  int nfish  = 100;
  int nsharks = 20;
  watorWorld = new wator(nfish, nsharks);
}

 void draw() {

   // end of each draw set pause back to true
   if(bSetStepMode) {
       bPaused = true;
     }
 }

void keyPressed() {
     switch(key) {
       // * space bar - Stop or start the simulation (toggle between these).
       case ' ':
       bPaused = ! bPaused;
       break;
       // * s - Take a single simulation step (leaving the simulation stopped).
       case 's':
        bSetStepMode = !bSetStepMode;
        if(!bSetStepMode) {
          bPaused = false;
        }
       break;
       // * r - Randomly re-initialize all of the cells in the grid.
       case 'r':
       updateCellDimm();
       break;
       // * =,+ - Increase the grid square size and randomize the grid.
       case '+':
       case '=':
       bPaused = true;
       if(bResize) {
         if(szDimm <= 600) {
           szDimm +=100;
           surface.setSize(szDimm,szDimm);
         }
       }else {
        if(cellDimm < cellDimmMax) {
          cellDimm++;
        }
       }
       updateCellDimm();
       bPaused = false;
       break;
      // * - (minus sign) - Decrease the grid square size and randomize the grid.
       case '-':
       bPaused = true;
       if(bResize) {
          if(szDimm > 100) {
            szDimm -=100;
            surface.setSize(szDimm,szDimm);
          }
        }else {
          if(cellDimm > 1) {
            cellDimm--;
         }
       }
       updateCellDimm();
       bPaused = false;
       break;
     }
}