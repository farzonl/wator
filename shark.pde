 class shark extends fish {
     // # of chronon a shark 
     // has to find food
     int starve;
     shark(int breed,int starve, int x, int y) {
        super(breed,x,y);
        this.starve = starve;
    }
     boolean isOccupied(int x, int y) {
        return watorWorld.grid[x][y].sOccupied;
    }

    void setOccupied(int x, int y, boolean status) {
        watorWorld.grid[x][y].sOccupied = status;
    }

    void setOccupied(boolean status) {
        watorWorld.grid[x][y].sOccupied = status;
    }
    
    void setOccupied() {
        watorWorld.grid[x][y].sOccupied = true;
    }
 }