//convolution gaussian blur
//Gaussian blur reduces the high frequencies of an image
//it is thus a lowpass filter
//gaussian blur matrix
float kernelMatrix[][] = { {0, 0, 0, 0, 0}, 
/*                     */  {0, 0, 0, 0, 0}, 
/*                     */  {0, 0, 1, 0, 0}, 
/*                     */  {0, 0, 0, 0, 0}, 
/*                     */  {0, 0, 0, 0, 0}, };
 
 void extra_setup2() {
  //calculate the gaussian "bell" in 2d from the central pixel of the kernel:
  
  float sigma = 3; //the width of the bell curve of a standard distribution (Gaussian Curve used to update the kernelMatrix[][])
  float normalizator = 0; //parameter used for normalisation 
  //(= make sure the sum of our sampled values from the bell-curve normal distribution is always 1 - to avoid losing brigthness)
  for (int i = 0; i < kernelMatrix.length; i++) {
    for (int j = 0; j < kernelMatrix[i].length; j++) {

      int x = i - (int)(kernelMatrix.length/2); //set the central element of the kernel as 0,0
      int y = j - (int)(kernelMatrix[i].length/2); //ibidem
      float z = (1.0/ ( TWO_PI * pow(sigma, 2.0))) * exp(-(pow(x, 2) + pow(y, 2))/(2.0*pow(sigma, 2.0)));
      kernelMatrix[i][j] = z;//assign the value of the curve at each pixel in the kernel to the matrix

      normalizator += z; //keep adding the sampled values, so that we can see how much their sum differ from 1 due to sampling approximation of a curve
    }
  }
   //normalize kernel matrix so that the final sum of the elements is 1
  for (int i = 0; i < kernelMatrix.length; i++) {
    for (int j = 0; j < kernelMatrix[i].length; j++) {
      kernelMatrix[i][j] = map(kernelMatrix[i][j], 0.0, normalizator, 0, 1);
    }
  }
 }

void extra3()
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
      color c = gaussBlur(x, y, kernelMatrix, img3);
      int location = x + y*width;
      pixels[location] = c;
    }
  }
  updatePixels();
  stroke(0);
  noFill();
  rect(xstart, ystart, w, w);
}

color gaussBlur(int x, int y, float kernel[][], PImage img)
{ 
  float red = 0.0;
  float green = 0.0;
  float blue = 0.0;

  //loop through convolution matrix
  for (int i = 0; i <  kernel.length; i++) {
    for (int j = 0; j < kernel[i].length; j++) {
      //which lpixel are texting?
      int xPixel = x + (i - (int)(kernel[i].length/2));
      int yPixel = y + (j - (int)(kernel.length/2));
      int pixelLoc = xPixel + yPixel*img.width;

      pixelLoc = constrain(pixelLoc, 0, img.pixels.length - 1); //make sure we are testing an existing pixel

      //extract the color components from the pixel analysed and multiply it by the appropriate convolution value
      red += (red(img.pixels[pixelLoc]) * kernel[i][j]);
      green += (green(img.pixels[pixelLoc]) * kernel[i][j]);
      blue += (blue(img.pixels[pixelLoc]) * kernel[i][j]);
    }
  }
  //make sure RGB is in the range
  red = constrain(red, 0, 255);
  green = constrain(green, 0, 255);
  blue = constrain(blue, 0, 255);
  
  return color(red, green, blue);
}