import processing.serial.*;
import cc.arduino.*;
Arduino arduino;
ArrayList<Thing> obstacles=new ArrayList<Thing>();
public void setup() {
  size(500, 500);
  arduino = new Arduino(this, Arduino.list()[0], 57600);
}

class Thing {
  float x, y, w, h;
  Thing(float ax, float ay, float aw, float ah) {
    x=ax;
    y=ay;
    w=aw;
    h=ah;
  }
  public void show() {
    fill(255);
    rect(x, y, w, h);
  }
}
public void draw() {
  int thing=0;
  if(thing==20){
    obstacles.add(new Thing((float)Math.random()*500,(float)-50,(float)50,(float)50));
  }
  for(int i=0;i<obstacles.size();i++){
    obstacles.get(i).show();
  }
  background(192);
  System.out.println();
  square(1, 400, 20);
}
