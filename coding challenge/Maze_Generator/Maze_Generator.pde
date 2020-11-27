float cols,rows;
float scl=10;
Cell[] grid;
Cell current;
ArrayList<Cell> stack=new ArrayList<Cell>();
void setup(){
  size(600,600);
  background(0);
  frameRate(120);
  cols=width/scl;
  rows=height/scl;
  grid=new Cell[(int)cols*(int)rows];
  for(int y=0;y<rows;y+=1){
    for(int x=0;x<cols;x+=1){
      int index=y*(int)cols+x;
      grid[index]=new Cell(x,y);
    }
  }
  current=grid[0];
  
  
}

void draw(){
  background(0);
    
  for(Cell c:grid){
    c.show();
  }
  
  current.visited=true;
  current.highlight();
  
  Cell next=current.checkNeighbors();
  
  if(next!=null){
    stack.add(current);
    removeWalls(current,next);
    next.visited=true;
    current=next;
  }
  else{
    if(stack.size()>0){
      stack.remove(stack.size()-1);
    }
    if(stack.size()>0){
      current=stack.get(stack.size()-1);
    }
  }
}

void removeWalls(Cell a,Cell b){
  int x=(int)b.position.x-(int)a.position.x;
  if(x==1){
    a.wall[3]=false;
    b.wall[1]=false;    
  }else if(x==-1){
    a.wall[1]=false;
    b.wall[3]=false;
  }
  int y=(int)b.position.y-(int)a.position.y;
  
  if(y==1){
    a.wall[2]=false;
    b.wall[0]=false;
  }
  else if(y==-1){
    a.wall[0]=false;
    b.wall[2]=false;
  }
}
