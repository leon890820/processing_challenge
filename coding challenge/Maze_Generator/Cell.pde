class Cell {
  PVector position;
  boolean[] wall={true, true, true, true};
  boolean visited=false;
  Cell(float x, float y) {
    position=new PVector(x, y);
  }
  void highlight(){
    fill(255,255,0);
    noStroke();
    rect(position.x*scl,position.y*scl,scl,scl);
  
  }
  
  void show() {
    noFill();
    stroke(255);
    float x=position.x*scl;
    float y=position.y*scl;
    if (wall[0]==true)line(x, y, x+scl, y);
    if (wall[1]==true)line(x, y, x, y+scl);
    if (wall[2]==true)line(x, y+scl, x+scl, y+scl);
    if (wall[3]==true)line(x+scl, y, x+scl, y+scl);
    if (visited) {
      fill(255, 0, 255, 100);
      noStroke();
      rect(x, y, scl, scl);
    }
  }
  int index(int i, int j) {
    if (i<0||j<0||i>cols-1||j>rows-1) return -1;
    return j*(int)cols+i;
  }

  Cell checkNeighbors() {
    ArrayList<Cell> neighbors=new ArrayList<Cell>();
    int i;

    i=index((int)position.x, (int)position.y-1);

    if (i!=-1) {
      Cell top=grid[i];
      if (top.visited==false)neighbors.add(top);
    }
    i=index((int)position.x-1, (int)position.y);
    if (i!=-1) {
      Cell left=grid[i];
      if (left.visited==false)neighbors.add(left);
    }
    i=index((int)position.x, (int)position.y+1);
    if (i!=-1) {
      Cell bottom=grid[i];
      if (bottom.visited==false)neighbors.add(bottom);
    }
    i=index((int)position.x+1, (int)position.y);
    if (i!=-1) {
      Cell right=grid[i];
      if (right.visited==false)neighbors.add(right);
    }

    if (neighbors.size()!=0) {
      int r=(int)random(neighbors.size());

      return neighbors.get(r);
    } else {
      return null;
    }
  }
}
