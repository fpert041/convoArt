//PRESS s TO SAVE A VERSION OF THE IMAGE DISPLAYED
//It will be saved in the sketch's main folder

//convolution algorithm for green Edges
//it mixes the outcome with the original image (0,0 = original / width,height = convoluted)

//convolution matrix (=kernel) for a "sharpen" effect stored as a 3x3 two-dimensional array 
float[][] matrix2 = { {-1, -1, -1}, 
/*               */  {-1, +8, -1}, //9 in the middle is "sharpen", 8 is "edge detection"
/*               */  {-1, -1, -1} };

/*float[][] matrix = { {-0, -1, -0}, 
/*               *///  {-1, +5, -1}, //5 in the middle is "sharpen" too (with corners being 0) - but less "drastic"
/*               *///  {-0, -1, -0} };  //if sum_of_weights = 1 the output picture will be as bright as the input one
                                        //if s_o_w > 1 the output will be brighter and vice versa if s_o_w < 1

void extraExtra_setup(){
  //img6 = loadImage("sources/"+"SliderColourSkyline.jpg");
  img6 = loadImage("sources/"+"manhattan3.jpg");
  img5 = img6.copy();
  //img5.resize(width,height);
}

void extraExtra()
{
  //set the image as background:
  PImage back = img5.copy();
  image(back, 0, 0, width, height);

  //in this example we can process a section of the image:
  //with these parameters though we will process it all
  int xstart = 0;
  int ystart = 0;
  int xend = img5.width;
  int yend = img5.height;

  img5.loadPixels();
  //begin our loop for every pixel
  for (int x = xstart; x < xend; x++) {
    for (int y = ystart; y < yend; y++) {
      //each pixel location(x,y) gets passed into a method called convolution()
      //The convolution() method returns a new colour to be desplayed
      color c = convolutionGreen(x, y, matrix2, img6);
      //color c = convolutionGreen(x, y, matrix2, img5); //different but possible alternative
      
      int location = x + y*img6.width;
      color original = img6.pixels[location];
      
      //crossfade between images (logarithmic interpolation)
      float interpolExpVal_x = 1; // modified img
      float interpolExpVal_y = 1;
      float interpolExpVal_x2 = 0.4; // original img
      float interpolExVal_y2 = 0.8;
      int endG = int( green(c)*(pow((float)x/img6.width, interpolExpVal_x))*pow((float)y/img6.height, interpolExpVal_y) + green(original)*(pow(1.0-(float)x/img6.width, interpolExpVal_x2))*pow(1.0-(float)y/img6.height, interpolExVal_y2) );
      int endB = int( blue(c)*(pow((float)x/img6.width, interpolExpVal_x))*pow((float)y/img6.height, interpolExpVal_y) + blue(original)*(pow(1.0-(float)x/img6.width, interpolExpVal_x2))*pow(1.0-(float)y/img6.height, interpolExVal_y2) );
      int endR = int( red(c)*(pow((float)x/img6.width, interpolExpVal_x))*pow((float)y/img6.height, interpolExpVal_y) + red(original)*(pow(1.0-(float)x/img6.width, interpolExpVal_x2))*pow(1.0-(float)y/img6.height, interpolExVal_y2) );
      
      float correction = 1.8;
      color end = color(constrain(endR*correction, 0, 255), constrain(endG*correction, 0, 255), constrain(endB*correction, 0, 255));
      
      img5.pixels[location] = end;
      //img5.pixels[location] = (c*x + original*(img6.width-x)); //cool but weird effect
      /*if(x>width/2 && y>width/2){ //only change pixels in the desired area
        pixels[location] = c;
      }*/
      
    }
  }
  img5.updatePixels();
}

color convolutionGreen(int x, int y, float[][] matrix, PImage imag) { //kernel is the size of the neighbouring filter
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

  //make sure RGB is in the range  AND apply CONTRAST INCREASE and BRIGHTNESS ADJUSTMENT (especially for green)
  rTot = constrain(rTot*1.3 -90.0, 0, 255);
  gTot = constrain(gTot*1.9 -90.0, 0, 255);
  bTot = constrain(bTot*1.3 -90.0, 0, 255);

  //return resulting colour
  //return color(rTot, gTot, bTot);
  return color(0, floor(rTot+gTot+bTot/3.0), 0 );
}

void keyPressed(){
  if(key=='s'){
    //create two arrays containing the current date and time components (down to seconds) as strings
    String[] a = new String[]{Integer.toString(year()), Integer.toString(month()), Integer.toString(day()) };
    String[] a2 = {Integer.toString(hour()), Integer.toString(minute()), Integer.toString(second())};
    
    //join the components of the arrays to create a unique identifier for the file
    String s = String.join("-",a);
    String s2 = String.join("",a2);   
    String ss = s + "_" +  s2;
    println("convoSketch_" + ss );
    img5.save("convoSketch_" + ss + ".png");
    //img5.save("convoSketch_" + ss + ".jpg");
  }
}