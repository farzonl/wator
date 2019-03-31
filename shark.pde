 class shark extends fish {
     // # of chronon a shark 
     // has to find food
     final int starve;
     int energy;
     shark(int breed,int starve, int x, int y) {
        super(breed,x,y);
        this.starve = starve;
        int energy = 0;
    }

    // At each chronon, a sharks energy gets closer to the starvation limit
    void update() {
        dies();
        super.update();
        energy++;
    }

    // if energy reaches starve, the shark dies.
    void dies() {
        if(energy >= starve) {
            //System.out.println("this shark died");
            watorWorld.sharks.remove(this);
        }
    }

    // if moved to cell occupied by fish eat the fish
    // restore energy
    void eats(CELL c) {
       c.f = this;
       c.sOccupied = true;
       c.fOccupied = false;
       energy = 0;
    }

    //shark has survived enough chronons to reproduce (same as the fish but pesky arraylist needs to change)
    void breed(int oldX, int oldY) {
        if(chronons >= breed) {
            chronons = 0;
            shark child = new shark(breed, starve, oldX, oldY);
            child.setOccupied();
            watorWorld.sharks.add(child);
        }
    }

    // shark swims randomly to an adjacent square occupied by a fish.
    // If no fish move to unoccupied cells (fish behavior implliments this call super)
    // don't move if no unoccupied  cells (again fish behavior )
    boolean swim() {
        int tempYu = getColIndex(y-1);
        int tempYd = getColIndex(y+1);
        int tempXr = getRowIndex(x+1);
        int tempXl = getRowIndex(x-1);
        ArrayList<CELL> cells = new ArrayList<CELL>();
        if(isOccupiedByFish(x,tempYu)) {
            cells.add(watorWorld.grid[x][tempYu]);
            //System.out.println("found fish at: (x: "+x+", y: "+y);
        }
        if(isOccupiedByFish(x,tempYd)) {
            cells.add(watorWorld.grid[x][tempYd]);
            //System.out.println("found fish at: (x: "+x+", y: "+y);
        }
        if(isOccupiedByFish(tempXr,y)) {
            cells.add(watorWorld.grid[tempXr][y]);
            //System.out.println("found fish at: (x: "+x+", y: "+y);
        }
        if(isOccupiedByFish(tempXl,y)) {
            cells.add(watorWorld.grid[tempXl][y]);
            //System.out.println("found fish at: (x: "+x+", y: "+y);
        }
        if(cells.size() > 0) {
            CELL cell = cells.get(floor(random(cells.size())));
            this.x = cell.i;
            this.y = cell.j;
            this.eats(cell);
            return true;
        }
        return super.swim();
    }


     boolean isOccupied(int x, int y) {
        return watorWorld.grid[x][y].sOccupied;
    }

    boolean isOccupiedByFish(int xf, int yf) {
        return watorWorld.grid[xf][yf].fOccupied;
    }

    void setUnOccupied() {
        watorWorld.grid[x][y].remove(CELL.eSHARK);
    }

    void setOccupied() {
        watorWorld.grid[x][y].addFish(this, CELL.eSHARK);
    }
 }