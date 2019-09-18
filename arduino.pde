import processing.serial.*;
import cc.arduino.*;
Arduino arduino;
ArrayList<Thing> obstacles=new ArrayList<Thing>();
public void setup() {
  size(500, 500);
  arduino = new Arduino(this, Arduino.list()[1], 57600);
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
    stroke(0, 0, 0);
    strokeWeight(1);
    fill(arduino.analogRead(3)>100?255:255-(float)arduino.analogRead(5)/2);
    rect(x, y, w, h);
  }
}
int thing=0;
int px;
boolean dead;
public void draw() {
  background((arduino.analogRead(3)>100)?0:(float)arduino.analogRead(5)/2);
  thing++;
  if(arduino.analogRead(3)>100){
    if(thing==15&&!dead){
      obstacles.add(new Thing((float)Math.random()*500,(float)-50,(float)50,(float)50));
      thing=0;
    }
  } else {
    if(thing==30&&!dead){
      obstacles.add(new Thing((float)Math.random()*500,(float)-50,(float)50,(float)50));
      thing=0;
    }
  }
  if(thing==((arduino.analogRead(3)>100)?40:20)){
    obstacles.add(new Thing((float)Math.random()*500,(float)-50,(float)50,(float)50));
    thing=0;
  }
  if(arduino.analogRead(6)>100&&!dead){
    px-=arduino.analogRead(3)>100?2:4;
  }
  if(arduino.analogRead(1)>100&&!dead){
   px+=arduino.analogRead(3)>100?2:(float)4;
  }
  for(int i=0;i<obstacles.size();i++){
    if(!dead){
    obstacles.get(i).y+=arduino.analogRead(3)>100?3:3/((float)arduino.analogRead(5)/500+0.2);
    }
    obstacles.get(i).show();
  }
  //System.out.println(arduino.analogRead(5));
  //System.out.println();
  rect(px, py, pw, ph);
  if(collide()){
    dead=true;
    explode(px,py);
  }

}
int py=400;
int pw=20;
int ph=20;
public boolean collide(){
   for(int i=0;i<obstacles.size();i++){
    if (obstacles.get(i).x < px+pw && obstacles.get(i).x+obstacles.get(i).w > px &&
        obstacles.get(i).y < py+ph && obstacles.get(i).y+obstacles.get(i).h >py) {
      return true;
    }
  }
  return false;
}
int circles=0;
int next=0;
public void explode(int x, int y){
  next=floor(circles/20);
  noFill();
  stroke(255, 0, 0);
  strokeWeight(5);
  circles+=5;
  for(int i=0;i<floor(circles/20);i++){
    ellipse(x,y,circles-i*20,circles-i*20);
  }
  //ellipse(x,y,circles,circles);
  noStroke();
  fill(255,circles/2);
  rect(0,0,500,500);
}
