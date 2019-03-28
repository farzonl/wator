 class shark extends fish {
     // # of chronon a shark 
     // has to find food
     int starve;

     boolean isOccupied(int x, int y) {
        return grid[x][y].sOccupied;
    }

    void setOccupied(int x, int y, boolean status) {
        grid[x][y].sOccupied = status;
    }
 }