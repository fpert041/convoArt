//contrast and brightness
void extra2()
{
  //set the image as background:
  image(img3, 0, 0, width, height); //img3 is loaded by extra_setup()

  //in this example we are only going to process a section of the image:
  //an 80x80 rectangle around the mouse location  
  int xstart = constrain(mouseX- w/2, 0, img3.width);
  int ystart = constrain(mouseY- w/2, 0, img3.height);
  int xend = constrain(mouseX+ w/2, 0, img3.width);
  int yend = constrain(mouseY+ w/2, 0, img3.height);

  loadPixels();
  //begin our loop for every pixel
  for (int x = xstart; x < xend; x++) {
    for (int y = ystart; y < yend; y++) {
      //each pixel location(x,y) gets passed into a method called filtrr()
      //The filtrr() method returns a new colour to be desplayed
      color c = filtrr(x, y, 2.0, -80.0, img3);
      int location = x + y*width;
      pixels[location] = c;
    }
  }
  updatePixels();
  stroke(0);
  noFill();
  rect(xstart, ystart, w, w);
}

color filtrr(int x, int y, float contrast, float brightness, PImage image)
{
  color loc = image.get(x, y);
  float r = red(loc);
  float g = green(loc);
  float b = blue(loc);
  //swap g and r - adjust contrast - adjust brightness
  float rNew = constrain(g*contrast + brightness, 0, 255);
  float gNew = constrain(r*contrast + brightness, 0, 255);
  float bNew = constrain(b*contrast + brightness, 0, 255);
  return color(rNew, gNew, bNew);
}