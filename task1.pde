//  variable for shape current position
PVector position = new PVector(0,0);

//  variable for vectorial velocity
PVector velocity = new PVector(0.2, 0.3);

void task1()
{
  position.add(velocity); //add velocity values every time this function is called
  translate(position.x, position.y);  //displace following shape(s) by vector position
  rect (0, 0, 200, 200);
}