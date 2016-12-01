//This code has 4 EXTRA tabs containing the details for the 4 tasks
//(usually inside one or more functions)
//To see the result of each task
//uncomment the relative function in DRAW()
//comment the ones you don't want to see

boolean fullScreen = false;

void settings(){
    size(1100, 800);
    //fullScreen();
    para();
}

void setup() 
{
  //surface.setResizable(true);
  extra_setup();
  extra_setup2();
  extraExtra_setup();
}

void draw()
{
   //task1();
  // task2();
  // task3();
  // task4_sepia();
  // task4_sepia_proper();
  // task4_experiments();
  // extra(); //convolution algorithm for increased sharpness
  //extra2(); //contrast and brightness
  //extra3(); //convolution gaussian blur: (img lowpass filter)
  extraExtra();

}