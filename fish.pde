class fish {
    // # of chrons a fish must live
    // to produce offspring
    int breed;
    int x, y;
    int chronons; // age of fish
    final int UP = 0, RIGHT= 1, DOWN=2, LEFT=3;
    
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
        return watorWorld.grid[x][y].fOccupied;
    }

    void setOccupied(int x, int y, boolean status) {
        watorWorld.grid[x][y].fOccupied = status;
    }

    void setOccupied(boolean status) {
        watorWorld.grid[x][y].fOccupied = status;
    }

    void setOccupied() {
        watorWorld.grid[x][y].fOccupied = true;
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
        int i = floor(random(4));
        int moveAttempts = 0;
        while(moveAttempts < 4) {
            switch(i) {
                case UP:
                {
                    int tempY = getColIndex(y-1);
                    if(!isOccupied(x,tempY)) {
                        this.setOccupied(false);
                        y = tempY;
                        this.setOccupied();
                        return true;
                    } // if occupied fall through.
                    moveAttempts++;
                }
                case RIGHT:
                {
                    int tempX = getRowIndex(x+1);
                    if(!isOccupied(tempX,y)) {
                        this.setOccupied(false);
                        x = tempX;
                        this.setOccupied();
                        return true;
                    } // if occupied fall through.
                    moveAttempts++;
                }
                case DOWN:
                {
                    int tempY = getColIndex(y+1);
                    if(!isOccupied(x,tempY)) {
                        this.setOccupied(false);
                        y = tempY;
                        this.setOccupied();
                        return true;
                    } // if occupied fall through.
                    moveAttempts++;
                }
                case LEFT:
                {
                    int tempX = getRowIndex(x-1);
                    if(!isOccupied(tempX,y)) {
                        this.setOccupied(false);
                        x = tempX;
                        this.setOccupied();
                        return true;
                    }
                    moveAttempts++;
                }
            }
            // random failed lets just iterate through.
            i = 0;
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