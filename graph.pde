
class Point {
    float x,y;
    int diameter = 4;
    Point(float x, float y) {
        this.x = x;
        this.y = y;
    }
    void draw() {
        fill(0);
        int radius = diameter/2;
        ellipse(x+radius,y+radius,diameter,diameter);
    }

    void print() {
        System.out.println("(x: "+x+", y: "+y);
    }
}
class Graph {
    int startX, startY;
    ArrayList<Point> Points;
    Graph(int startX, int startY) {
        this.startX = startX;
        this.startY = startY;
        Points = new ArrayList<Point>();
    }
    void update() {
        int numSharks = watorWorld.sharks.size();
        int numFish = watorWorld.fish.size();
        int numCells = ROWS*COLS;
        float yShark = numSharks / (float) numCells;
        float xFish = numFish / (float) numCells;
        float y = map(yShark, 0, .5, height, 0);
        float x = map(xFish, 0,1.0,startX,width);
        Point np = new Point(x, y);
        //np.print();
        if(Points.size() > 200) {
            Points.remove(0);
        }
        Points.add(np);
    }
    void draw() {
        fill(255);
        rectMode(CORNER);
        rect(startX,startY,width, height);

        for(int i = 0; i < Points.size(); i++) {
            Points.get(i).draw();
        }

        update();
    }
}