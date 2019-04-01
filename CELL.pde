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