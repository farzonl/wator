class fish {
    // # of chrons a fish must live
    // to produce offspring
    final int breed;
    int x, y;
    int chronons; // age of fish
    fish(int breed, int x, int y) {
        this.breed = breed;
        this.x = x;
        this.y = y;
        this.chronons = 0;
    }
    void drawShape(int x, int y,int diameter){
        if(bDrawCircles){
            int radius = diameter/2;
            ellipse(x+radius,y+radius,diameter,diameter);
        } else{
            rect(x,y,diameter,diameter);
        }
    }
    void draw() {
         noStroke();
         drawShape(this.x*cellDimm,this.y*cellDimm,cellDimm);
    }
    void update() {
        int oldX = x;
        int oldY = y;
        boolean moved = swim();
        if(moved) {
            breed(oldX, oldY);
        }
        chronons++;
    }
    boolean isOccupied(int x, int y) {
        return watorWorld.grid[x][y].fOccupied || watorWorld.grid[x][y].sOccupied;
    }

    void setUnOccupied() {
        watorWorld.grid[x][y].remove(CELL.eFISH);
    }

    void setOccupied() {
        watorWorld.grid[x][y].addFish(this, CELL.eFISH);
    }

    // check if fish survived specified chronons to reproduce. 
    // check on movement to neighbor square, leave behind a new fish at old position. 
    // set chron to 0
    void breed(int oldX, int oldY) {
        if(chronons >= breed) {
            chronons = 0;
            fish child = new fish(breed, oldX, oldY);
            child.setOccupied();
            watorWorld.fish.add(child);
        }
    }
    
    // At each chronon, select 1 unoccupied  adjacent cell at random and move there. 
    // If there are none, then don't move
    boolean swim() {
        int tempYu = getRowIndex(y-1);
        int tempYd = getRowIndex(y+1);
        int tempXr = getColIndex(x+1);
        int tempXl = getColIndex(x-1);
        ArrayList<CELL> cells = new ArrayList<CELL>();
        if(!isOccupied(x,tempYu)) {
            cells.add(watorWorld.grid[x][tempYu]);
            //System.out.println("found fish at: (x: "+x+", y: "+y);
        }
        if(!isOccupied(x,tempYd)) {
            cells.add(watorWorld.grid[x][tempYd]);
            //System.out.println("found fish at: (x: "+x+", y: "+y);
        }
        if(!isOccupied(tempXr,y)) {
            cells.add(watorWorld.grid[tempXr][y]);
            //System.out.println("found fish at: (x: "+x+", y: "+y);
        }
        if(!isOccupied(tempXl,y)) {
            cells.add(watorWorld.grid[tempXl][y]);
            //System.out.println("found fish at: (x: "+x+", y: "+y);
        }
        /*if(!isOccupied(tempXl,tempYu)) {
            cells.add(watorWorld.grid[tempXl][tempYu]);
            //System.out.println("found fish at: (x: "+x+", y: "+y);
        }
        if(!isOccupied(tempXl,tempYd)) {
            cells.add(watorWorld.grid[tempXl][tempYd]);
            //System.out.println("found fish at: (x: "+x+", y: "+y);
        }

        if(!isOccupied(tempXr,tempYu)) {
            cells.add(watorWorld.grid[tempXr][tempYu]);
            //System.out.println("found fish at: (x: "+x+", y: "+y);
        }
        if(!isOccupied(tempXr,tempYd)) {
            cells.add(watorWorld.grid[tempXr][tempYd]);
            //System.out.println("found fish at: (x: "+x+", y: "+y);
        }*/
        if(cells.size() > 0) {
            CELL cell = cells.get(floor(random(cells.size())));
            //System.out.println("previous cell: (x: "+x+", y: "+y);
            setUnOccupied();
            this.x = cell.i;
            this.y = cell.j;
            setOccupied();
            //System.out.println("curr  cell: (x: "+x+", y: "+y);
            return true;
        }
        return false;
    }

    int getIndex(int index, int modBy) {
      return (index + modBy) % modBy;
    }
    
    int getColIndex(int index) {
      return getIndex(index, COLS);
    }
    
    int getRowIndex(int index) {
      return getIndex(index, ROWS);
    }
}