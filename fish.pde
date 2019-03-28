class fish {
    // # of a fish must have
    // to produce offspring
    int breed;
    int x, y;
    int chronons; // age of fish
    final int UP = 0, RIGHT= 1, DOWN=2, LEFT=3;
    
    void update() {
        swim();
        chronons++;
    }
    boolean isOccupied(int x, int y) {
        return grid[x][y].fOccupied;
    }

    void setOccupied(int x, int y, boolean status) {
        grid[x][y].fOccupied = status;
    }

    void swim() {
        int i = floor(random(4));
        switch(i): {
            case UP:
            int tempY = getColIndex(y-1);
            if(!isOccupied(x,tempY)) {
                setOccupied(x,y, false);
                y = tempY;
                setOccupied(x,y, true);
                return;
            } // if occupied fall through.
            case RIGHT:
            int tempX = getRowIndex(x+1);
            if(!isOccupied(tempX,y)) {
                setOccupied(x,y, false);
                x = tempX;
                setOccupied(x,y, true);
                return;
            } // if occupied fall through.
            case DOWN:
            int tempY = getColIndex(y+1);
            if(!isOccupied(x,tempY)) {
                setOccupied(x,y, false);
                y = tempY;
                setOccupied(x,y, true);
                return;
            } // if occupied fall through.
            case LEFT:
            int tempX = getRowIndex(x-1);
            if(!isOccupied(tempX,y)) {
                setOccupied(x,y, false);
                x = tempX;
                setOccupied(x,y, true);
                return;
            }
        }

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