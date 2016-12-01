//  scaling variable - it could have been a float for a UNIFORM scale
PVector zoom = new PVector(1, 1);

//  variable for scaling speed
PVector zoomSpeed = new PVector(0.01, 0.002);

void task2()
{
  position.add(velocity); //add velocity values every time this function is called
  translate(position.x, position.y);  //displace following shape(s) by vector "position"
  
  zoom.add(zoomSpeed); //add zoomSpeed values every time this function is called
  scale(zoom.x, zoom.y); //scale following shape(s) by vector "zoom"
  
  rect (0, 0, 200, 200);
}