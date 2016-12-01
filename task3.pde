//variable for an image
PImage img;
//...and its copies
PImage img2;
//blur variable
float blur = 0.7;
//blurring factor
float bspeed = 0.01;

void para()
{
  //load an image into img variable
  img = loadImage("sources/"+"ghost4.png");
  img2=img.copy();
}

void task3()
{
  // blur the entire processing window with filter() function
  // blur += bspeed;
  // filter(BLUR, blur);
 
 
  // or blur a copy of the image that gets updated each frame
  blur += bspeed;
  img2=img.copy();
  img2.filter(BLUR, blur);
 
  position.add(velocity); //add velocity values every time this function is called
  translate(position.x, position.y);  //displace following shape(s) by vector "position"
  
  zoom.add(zoomSpeed); //add zoomSpeed values every time this function is called
  scale(zoom.x, zoom.y); //scale following shape(s) by vector "zoom"
  
  
  image(img2, 10, 10);
}