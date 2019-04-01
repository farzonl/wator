import java.util.Iterator;

int cellDimm = 4;
int cellDimmMax;
int COLS, ROWS;
int szDimm;
Boolean bPaused = true, bSetStepMode = false, bResize = false,
        bDebug = false, bDrawGrid = false, bDrawCircles = false, bShowInstructions = false;
Graph g;
WatorSim watorWorld;

void settings()
{
    size(800, 800);
}

void setup() {
  szDimm = 800;
  updateCellDimm();
}

void mousePressed() {
  if (mouseX<(width/2) && mouseX >0 && mouseY <height && mouseY > 0) 
  {
    int msX = mouseX/cellDimm;
    int msY = mouseY/cellDimm;
    if(bDebug) {
      watorWorld.grid[msX][msY].print();
    }
  }
}
void updateCellDimm() {
  cellDimmMax = szDimm/2;
  if(cellDimm > cellDimmMax) {
    cellDimm = cellDimmMax;
  }
  int halfWidth = width/2;
  COLS = (halfWidth) /cellDimm;
  ROWS = height/cellDimm;
  int nfish  =  max((COLS*ROWS)/8,1);
  int nsharks = max(nfish/4,1);
  g = new Graph(halfWidth,0);
  watorWorld = new WatorSim(nfish, nsharks);
}

void drawGrid() {
  stroke(0,255,0);
  strokeWeight(2);
  for (int x=0; x<=COLS; x++) {
      line(x*cellDimm,0,x*cellDimm,height);
  }
  int halfWidth = width/2;
  for (int y=0; y<=ROWS; y++) {
      line(0,y*cellDimm,halfWidth,y*cellDimm);
  }
}

void writeLine(String S, int i) {
    // writes S at line i
    text(S, width/2, 25+i*10);
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
        writeLine("number of fish: "+  watorWorld.fish.size(),L++);
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
   g.draw();
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
       {
       boolean oldPause = bPaused;
       bPaused = true;
       if(bResize) {
         if(szDimm <= 800) {
           szDimm +=100;
           surface.setSize(szDimm,szDimm);
         }
       }else {
        if(cellDimm < cellDimmMax) {
          cellDimm++;
        }
       }
       updateCellDimm();
       bPaused = oldPause;
       }
       break;
      // * - (minus sign) - Decrease the grid square size and randomize the grid.
       case '-':
       {
       boolean oldPause = bPaused;
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
       bPaused = oldPause;
       }
       break;
     }
}