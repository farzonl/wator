import java.util.Iterator;

int cellDimm = 2;
int cellDimmMax;
int COLS, ROWS;
int szDimm;
Boolean bPaused = false, bSetStepMode = false, bResize = false,
        bDrawGrid = false, bDrawCircles = false, bShowInstructions = false;


class CELL {
    int i,j;
    CELL(int i, int j) {
      this.i = i;
      this.j = j;
    }
    boolean fOccupied = false , sOccupied = false;
}

class wator {
    ArrayList<shark> sharks;
    ArrayList<fish> fish;
    final int FISH_BREED = 6;
    final int SHARK_BREED = 8;
    final int SHARK_STARVE = 12;
    final int eSHARK= 0, eFISH = 1, eWATER = 2;
    color sharkColor = color(192,192,192); // silver
    color fishColor = color(255, 153, 153); // salmon
    color oceanColor = color(0,41,58); // ocean blue
    int nfish;
    int nsharks;
    CELL[][] grid;
    wator(int nfish, int nsharks) {
        this.nfish = nfish;
        this.nsharks = nsharks;
        grid = new CELL[COLS][ROWS];
        fish = new ArrayList<fish>();
        sharks = new ArrayList<shark>();
        ArrayList<CELL> unoccupiedCells = new ArrayList<CELL>();
        int fishRemainingToPlace = nfish;
        int sharksRemainingToPlace = nsharks;
        for (int i = 0; i < COLS; i++) {
          for (int j = 0; j < ROWS; j++) { 
            grid[i][j] = new CELL(i,j);
            int pick = floor(random(3));
            if(eFISH == pick && fishRemainingToPlace > 0) {
              grid[i][j].fOccupied = true;
              fishRemainingToPlace--;
              fish.add(new fish(FISH_BREED, i, j));
            } else if(eSHARK == pick && sharksRemainingToPlace > 0) {
              grid[i][j].sOccupied = true;
              sharks.add(new shark(SHARK_BREED, SHARK_STARVE, i, j));
              sharksRemainingToPlace--;
            } else {
              unoccupiedCells.add(grid[i][j]);
            }
          }
        }
        Iterator itr = unoccupiedCells.iterator(); 
        while (itr.hasNext()) 
        {
          if(fishRemainingToPlace == 0 && sharksRemainingToPlace == 0) {
            break;
          }
          if(sharksRemainingToPlace > 0) {
            CELL cell  = (CELL) itr.next();
            cell.sOccupied = true;
            sharks.add(new shark(SHARK_BREED, SHARK_STARVE, cell.i, cell.j));
            sharksRemainingToPlace--;
            itr.remove();
          } else if(fishRemainingToPlace > 0) {
              CELL cell  = (CELL) itr.next();
              cell.fOccupied = true;
              fish.add(new fish(FISH_BREED, cell.i, cell.j));
              fishRemainingToPlace--;
              itr.remove();
          }
        }
    }

    void draw() {
      for(int i = 0; i < fish.size(); i++) {
        fill(fishColor);
        fish.get(i).draw();
      }
      for(int i = 0; i < sharks.size(); i++) {
        fill(sharkColor);
        sharks.get(i).draw();
      }
    }
}
wator watorWorld;

void settings()
{
    size(600, 600);
}

void setup() {
  szDimm = 600;
  //size(600, 600);
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

void drawGrid() {
  stroke(0,255,0);
  strokeWeight(2);
  for (int x=0; x<=COLS; x++) {
      line(x*cellDimm,0,x*cellDimm,height);
  }
  for (int y=0; y<=ROWS; y++) {
      line(0,y*cellDimm,width,y*cellDimm);
  }
}

void writeLine(String S, int i) {
    // writes S at line i
    text(S, 30, 25+i*10);
}

void drawInstructions() {
     fill(color(255,0,0));
     int L=0; // line counter, incremented below for ech line
     if(bShowInstructions) {
        writeLine("(press r) to enter resize " + (!bResize ? "window mode" : "cell dimmensions mode"),L++);
        writeLine("(press +) to increase " + (bResize ? "window size" : "cell dimmensions"),L++);
        writeLine("(press -) to decrease " + (bResize ? "window size" : "cell dimmensions"),L++);
        writeLine("cell dimmensions: " + cellDimm,L++);
        writeLine("window size: " + szDimm + " by " + szDimm,L++);
        writeLine("(press g) toggle grid (large cell dimm debug tool)", L++);
        writeLine("(press spacebar) Game is: " + (bPaused ? "paused" : "running") , L++);
     } else {
         writeLine("(press q) to show instructions.",L++);
     }
}

 void draw() {
   background(watorWorld.oceanColor);
   watorWorld.draw();
   // end of each draw set pause back to true
   if(bSetStepMode) {
       bPaused = true;
   }

   drawInstructions();

   if(bDrawGrid) {
        drawGrid();
    }
 }

void keyPressed() {
     switch(key) {
       // * space bar - Stop or start the simulation (toggle between these).
       case ' ':
       bPaused = ! bPaused;
       break;
       case 'g':
        bDrawGrid = !bDrawGrid;
        break;
       case 'q':
        bShowInstructions = !bShowInstructions;
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