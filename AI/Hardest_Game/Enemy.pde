class Enemy {
  PVector position;
  PVector[] path;
  float radius;
  float speed;
  float time;
  int nowPos;
  String type;
  int n;
  Enemy(String t, float x, float y, PVector[] dot, float _r, float s) {
    position=new PVector(x, y);
    path=dot;
    radius=_r;
    speed=s;
    time=0;
    nowPos=0;
    type=t;
    n=dot.length;
  }

  void show() {
    fill(0, 0, 255);
    noStroke();
    circle(position.x, position.y, radius);
  }

  void updata() {


    position.x=map(time, 0, 1, path[nowPos%n].x, path[(nowPos+1)%n].x);
    position.y=map(time, 0, 1, path[nowPos%n].y, path[(nowPos+1)%n].y);

    time+=0.01*speed;
    if (time>1) {
      nowPos+=1;
      time=0;
    }
  }
}
