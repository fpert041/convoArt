color oldPixelColour;
color updatedPixelColour;
float r, g, b;
float newR, newG, newB;

//posterize variable
float p = 2;
//posterizing factor
float pspeed = 13;


//create a sepia tone by turning the image in grayscale
//and then applying a yellow-ish tint
void task4_sepia()
{
  img2.filter(GRAY);
  tint(230, 190, 0);
  image(img2, 0, 0);
  noTint();
}


//create a proper sepia tone by altering each pixel with an algorhythm
//
//-the code in the following function is based on a sketch
//by Laura Maye, University of Limerick
//and on how pixels are ordered as seen in the Lecture 1 slides
//-the specific values to modify the colours
//are the values for sepia tone that are recommended by Microsoft.
//Ref:http://www.techrepublic.com/blog/how-do-i/how-do-i-convert-images-to-grayscale-and-sepia-tone-using-c/
void task4_sepia_proper()
{
  //get the colour values from each pixel in the image
  for (int x = 0; x < img.width; x++)
  {
    for(int y = 0; y < img.height; y++)
    {
      oldPixelColour = img.get(x, y);
      r = red(oldPixelColour);
      g = green(oldPixelColour);
      b = blue(oldPixelColour);
      //assign to the new RGB variables the sepia tone colours
      newR = r * 0.393 + g * 0.769 + b * 0.189;
      newG = r * 0.349 + g * 0.686 + b * 0.168;
      newB = r * 0.272 + g * 0.534 + b * 0.131;
      //set all numbers bigger than 255 to 255
      if (newR > 255)
      {
        newR = 255;
      }
      if (newG > 255)
      {
        newG = 255;
      }
      if (newB > 255)
      {
        newB = 255;
      }
      //set a color variable with the updated colour values 
      updatedPixelColour = color(newR, newG, newB);
      //assign each updated pixel to a new image variable (not to overwrite the old)
      img2.set(x, y, updatedPixelColour);
      //now end the for loops that retrived and changed the colours for each pixels
    }
  }
  
  //display the new image
  image(img2, 10, 10);
}

void task4_experiments()
{
  // posterize a copy of the image loaded in task3 that gets updated each frame
  p += pspeed;
  if (p >= 239) p = 2;
  img2=img.copy();
  img2.filter(POSTERIZE, p);
  img2.filter(INVERT);
  img2.filter(ERODE);
  
  //display the image
  image(img2, 10, 10);
}