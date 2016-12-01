//convolution algorithm for increased sharpness
//from chap. 15 - LEarning Processing by D. Shiffman

PImage img3, img4;
PImage img5, img6; //for extraExtra
int w = 400;

//convolution matrix (=kernel) for a "sharpen" effect stored as a 3x3 two-dimensional array 
float[][] matrix = { {-1, -1, -1}, 
/*               */  {-1, +9, -1}, //9 in the middle is "sharpen", 8 is "edge detection"
/*               */  {-1, -1, -1} };

/*float[][] matrix = { {-0, -1, -0}, 
/*               *///  {-1, +5, -1}, //5 in the middle is "sharpen" too (with corners being 0) - but less "drastic"
/*               *///  {-0, -1, -0} };  //if sum_of_weights = 1 the output picture will be as bright as the input one
                                        //if s_o_w > 1 the output will be brighter and vice versa if s_o_w < 1


void extra_setup() {
  img4 = loadImage("sources/"+"sunset.jpg");
  img3 = img4.copy();
  img3.resize(width, height);
}

void extra()
{
  //set the image as background:
  image(img3, 0, 0, width, height);

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
      //each pixel location(x,y) gets passed into a method called convolution()
      //The convolution() method returns a new colour to be desplayed
      color c = convolution(x, y, matrix, img3);
      int location = x + y*width;
      pixels[location] = c;
    }
  }
  updatePixels();
  stroke(0);
  noFill();
  rect(xstart, ystart, w, w);
}

color convolution(int x, int y, float[][] matrix, PImage imag) { //kernel is the size of the neighbouring filter
  float rTot = 0.0;
  float gTot = 0.0;
  float bTot = 0.0;
  int offset = (int) (matrix.length / 2);

  //loop through convolution matrix
  for (int i = 0; i<matrix.length; i++) {
    for (int j = 0; j < matrix.length; j++) {
      //what pixel are we testing?
      int xloc = x + i-offset;
      int yloc = y + j-offset;
      int loc = xloc + imag.width*yloc;

      //make sure we have't walked off the edge of the pixel array
      loc = constrain(loc, 0, imag.pixels.length-1);

      //calculate the convolution
      //we sum all the neighbouring pixels multiplied by the values in the convolution mtx
      rTot += (red(imag.pixels[loc])*matrix[i][j]);
      gTot += (green(imag.pixels[loc])*matrix[i][j]);
      bTot += (blue(imag.pixels[loc])*matrix[i][j]);
    }
  }

  //make sure RGB is in the range  AND apply CONTRAST INCREASE and BRIGHTNESS ADJUSTMENT
  rTot = constrain(rTot*1.3 -90.0, 0, 255);
  gTot = constrain(gTot*1.3 -90.0, 0, 255);
  bTot = constrain(bTot*1.3 -90.0, 0, 255);

  //return resulting colour
  return color(rTot, gTot, bTot);
}