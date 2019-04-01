import java.util.Iterator;

int cellDimm = 200;
int cellDimmMax;
int COLS, ROWS;
int szDimm;
Boolean bPaused = true, bSetStepMode = false, bResize = false,
        bDrawGrid = true, bDrawCircles = false, bShowInstructions = false;


class CELL {
    int i,j;
    static final int eSHARK= 0, eFISH = 1;
    fish f;
    CELL(int i , int j) {
      this.i = i;
      this.j = j;
    }

    void remove(int fishType) {
      this.f = null;
      switch(fishType) {
        case eSHARK:
        sOccupied = false;
        break;
        case eFISH:
        fOccupied = false;
        break;
      }
    }

    void addFish(fish f, int fishType) {
      this.f = f;
      switch(fishType) {
        case eSHARK:
        sOccupied = true;
        //fOccupied = false;
        break;
        case eFISH:
        fOccupied = true;
        //sOccupied = false;
        break;
      }
    }
    boolean fOccupied = false , sOccupied = false;

    void print() {
      if(fOccupied && sOccupied) {
         System.out.println("error should be shark or fish");
      } else if(fOccupied) {
        if(this.f == null) {
          System.out.println("should be occupied by fish");
        } else {
          System.out.println("found fish at: (x: "+i+", y: "+j);
          System.out.println("occupied by fish with chronons left to breed: "+ (f.breed - f.chronons));
        }
      } else if(sOccupied) {
        if(this.f == null) {
          System.out.println("should be occupied by shark");
        } else {
          System.out.println("found shark at: (x: "+i+", y: "+j);
          System.out.println("occupied by shark with chronons left to breed: "+(f.breed - f.chronons));
          shark s = (shark)f;
          System.out.println("energy remaining: "+(s.starve - s.energy));
        }
      }
      else {
        System.out.println("found water at: (x: "+i+", y: "+j);
      }
    }
}

class wator {
    ArrayList<shark> sharks;
    ArrayList<fish> fish;
    final int FISH_BREED = 6;
    final int SHARK_BREED = 8;
    final int SHARK_STARVE = 12;
    color sharkColor = color(192,192,192); // silver
    color fishColor = color(255, 153, 153); // salmon
    color oceanColor = color(0,41,58); // ocean blue
    int nfish;
    int nsharks;
    CELL[][] grid;
    //wator() {
    wator(int nfish, int nsharks) {
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

void mousePressed() {
  if (mouseX<width && mouseX >0 && mouseY <height && mouseY > 0) 
  {
    int msX = mouseX/cellDimm;
    int msY = mouseY/cellDimm;
    watorWorld.grid[msX][msY].print();
  }
}
void updateCellDimm() {
  cellDimmMax = szDimm/2;
  if(cellDimm > cellDimmMax) {
    cellDimm = cellDimmMax;
  }

  COLS = width /cellDimm;
  ROWS = height/cellDimm;
  int nfish  =  2;//100;
  int nsharks = 1;//20;
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
     fill(color(255));
     int L=0; // line counter, incremented below for ech line
     if(bShowInstructions) {
        writeLine("(press r) to enter resize " + (!bResize ? "window mode" : "cell dimmensions mode"),L++);
        writeLine("(press +) to increase " + (bResize ? "window size" : "cell dimmensions"),L++);
        writeLine("(press -) to decrease " + (bResize ? "window size" : "cell dimmensions"),L++);
        writeLine("cell dimmensions: " + cellDimm,L++);
        writeLine("window size: " + szDimm + " by " + szDimm,L++);
        writeLine("number of fish: "+ watorWorld.fish.size(),L++);
        writeLine("number of sharks: "+ watorWorld.sharks.size(),L++);
        writeLine("(press g) toggle grid (large cell dimm debug tool)", L++);
        writeLine("(press spacebar) Game is: " + (bPaused ? "paused" : "running") , L++);
     } else {
         writeLine("(press q) to show instructions.",L++);
     }
}

 void draw() {
   if(bSetStepMode) {
       bPaused = false;
   }
   background(watorWorld.oceanColor);
   watorWorld.draw();
   // end of each draw set pause back to true
   drawInstructions();

   if(bDrawGrid) {
        drawGrid();
    }

    if(bSetStepMode) {
       bPaused = true;
       bSetStepMode = false;
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
        bSetStepMode = true;
        if(bSetStepMode) {
          bPaused = true;
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