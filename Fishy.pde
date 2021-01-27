/*
  To run, export application and run as administrator
*/

import java.awt.Rectangle;
import java.awt.Robot;
import java.awt.event.KeyEvent;
import java.io.IOException;

PImage screenshot = createImage(displayWidth, displayHeight, ARGB);
Rectangle dimension  = new Rectangle(displayWidth, displayHeight);

Robot robot;
Config config;
KeyPresser keyPresser;

import ddf.minim.*;
import ddf.minim.analysis.*;

AudioOutput output;

SineSound ss;
float baseTone = 0.0;
 
 
void setup() {
  fullScreen();
  background(0, 0, 0);
  smooth(3);
  frameRate(12);  //scan boxes every frame (set to 24) and only take a screenshot every 4th frame? 12
  fill(255, 0, 0, 0);
  
  output = minim.getLineOut();
  
  screenshot = createImage(displayWidth, displayHeight, ARGB);
  dimension  = new Rectangle(displayWidth, displayHeight); 
  
  try {
    robot = new Robot();
  } catch (Exception e) {
    e.printStackTrace();
    exit();
  }
  
  config = new Config();
  keyPresser = new KeyPresser();
  /*
  String[] snapShotArgs = {"SnapShot"};
  SnapShot snapShot = new SnapShot();
  PApplet.runSketch(snapShotArgs, snapShot);
  
  String[] overlayArgs = {"Overlay"};
  Overlay overlay = new Overlay();
  PApplet.runSketch(overlayArgs, overlay);
  */
  // PImage img = snapShot.takeSnapShot(screenshot, dimension, robot);
  // image(img, 0, 0, height, width);
  

  colorMode(RGB);
  imageMode(CORNER);
  config = new Config();    
  
  delay(3000);
  setState(0);
}

void draw()
{
  if(mouseX < 5 && mouseY < 5){
    return;
  }
  if(getState() > -1)
  {
    fish();
  }
}

void mousePressed()
{
  if(mouseX < 5 && mouseY < 5){
    exit();
  } 
}

void keyPressed(){
  if(key == '0'){
    setState(0);
    delay(5000);
  }

}

void fish(){
  background(0, 0, 0);

  PImage img = grabScreenshot(screenshot, dimension, robot);
  image(img, 0, 0, width, height);
  
  drawBox(config.leftBox);
  drawBox(config.rightBox);
  drawBox(config.healthBox);
  
  drawBox(config.macroPaletteBox);
  
  drawBox(config.catchSmallFishBoxA);
  drawBox(config.catchSmallFishBoxB);
  
  drawBox(config.catchBigFishBoxA);
  drawBox(config.catchBigFishBoxB);
  
  drawBox(config.epicCatchBoxA);
  drawBox(config.epicCatchBoxB);
  
/*  
  drawBox(config.goodFeelingPositive);
  drawBox(config.goodFeelingNegative);
  
  drawBox(config.dontKnowPositive);
  drawBox(config.dontKnowNegative);
  
  drawBox(config.badFeelingPositive);
  drawBox(config.badFeelingNegative);
  
  drawBox(config.terribleFeelingPositive);
  drawBox(config.terribleFeelingNegative);
*/
  if(getState() == 0){
    beginFishing();
  }
  else if(getState() == 1){
    if(checkForFishHealth())
    {
      println("We have a bite!");
      setState(2);  // We have a bite!
    }
    
    else if(checkIfReadyToCast())
    {
      setState(0);
    }    
  }
  else if(getState() == 2){
    delay(1500);
    PImage chatLogAnalysisImg = grabScreenshot(screenshot, dimension, robot);
    image(chatLogAnalysisImg, 0, 0, width, height);
    /*
    if(checkForEpicCatch() && !config.wantBigFish){
      keyPresser.pressEsc();
      delay(getDelay(4125, 6250));
      setState(0);
    }
    */
    if(checkForSmallFish() && config.wantSmallFish)
    { 
      setState(3);
      if(doSkillCheck())
      {
        println("We are confident we can catch this!"); 
        setState(3);
      }      
    }
    else if(checkForBigFish() && config.wantBigFish){
      setState(3);
    }
    else if(checkForItem() && config.wantItem){
      setState(3);
    }
    else{
      delay(getDelay(100, 250));
      if(config.wantBigFish){
        delay(700);
        if(checkForEpicCatch()){
          output.playNote(0, 0.10, new SineSound(baseTone + 200));
          setState(3);
        }
        else{
          keyPresser.pressEsc();
          println("Whatever this is, we don't want it...");
          delay(getDelay(4000, 6250));
          setState(0); 
        }
      }
      else{
        keyPresser.pressEsc();
        println("Whatever this is, we don't want it...");
        delay(getDelay(4000, 6250));
        setState(0);
      }
      
    }
  }
  else if(getState() == 3){
    
    if(random(0, 1000) > mouseY){
      if(checkForLeftArrow())
      {
        keyPresser.pressLeft();
      }
      if(checkForRightArrow())
      {
        keyPresser.pressRight();
      }
    }
    if(!checkForFishHealth() && !checkIfReadyToCast())
    {
      println("Reel it in!");
      delay(getDelay(1200, 1500));
      keyPresser.pressEnter();
      config.fishCaught++;
      println("Progress: " + config.fishCaught + " out of " + config.catchTarget);
      delay(5000);
      setState(0);
    }
  }
}

void beginFishing(){
  if(config.fishCaught < config.catchTarget)
  {
    if(random(0, 100) >= 92)
    {
      println("Taking a Break!");
      delay(int(random(10000, 33420)));
    }
    delay(getDelay(1000, 3000 + int(round(random(mouseX * 1.5, mouseX * 3)))));
    if(checkIfReadyToCast()){
      println("Casting!");
      keyPresser.pressAlt();
      delay(getDelay(500, 950));
      keyPresser.pressOne();
      delay(getDelay(500, 1250));
      keyPresser.releaseAlt();
      delay(4000);  // 5 seconds to take out fishing rod before we begin scanning
      setState(1);
    }
  }
  else
  {
     println("Target met!"); 
  }  
  
}

boolean scanImageForColour(int box[], color lightColor, color darkColor)
{
  //maybe have a counter and you need to return > 20 pixels? or smoething
  for (int x = box[0]; x <= (box[0] + box[2]); x++) {
    for (int y = box[1]; y <= (box[1] + box[3]); y++ ) {
      color c = get(x, y);
      if(c <= lightColor && c >= darkColor)
      {
        return true;
      }
    }
  }
  return false;
}


boolean doSkillCheck()
{
  if(doubleCheckSkillLevel(config.goodFeelingPositive, config.goodFeelingNegative))
  { 
    println("You have a good feeling about this one.");
    return true;
  }
  if(doubleCheckSkillLevel(config.dontKnowPositive, config.dontKnowNegative))
  {
    println("You don't know if you have enough skill to reel this one in.");
    return true;
  }
  
  return false;
  
}

boolean doubleCheckSkillLevel(int positiveBox[], int negativeBox[])
{
  if(scanImageForColour(positiveBox, config.lightWhite, config.darkWhite) && !scanImageForColour(negativeBox, config.lightWhite, config.darkWhite))
  {
    return true;
  }
  return false;
  
}

boolean checkForFishHealth()
{
  if(scanImageForColour(config.healthBox, config.lightRed, config.darkRed))
  {
    return true;
  }
  else
  {
    return false;
  }
}

boolean checkForLeftArrow()
{
  if (scanImageForColour(config.leftBox, config.lightSilver, config.darkSilver) == true || scanImageForColour(config.leftBox, config.lightGold, config.darkGold) == true)  //make a global for 'leftKeyPress' insead of 83
  {
    return true;
  }
  else
  {
    return false; 
  }
}

boolean checkForRightArrow()
{
  if (scanImageForColour(config.rightBox, config.lightSilver, config.darkSilver) == true || scanImageForColour(config.leftBox, config.lightGold, config.darkGold) == true)  //make a global for 'leftKeyPress' insead of 83
  {
    return true;
  }
  else
  {
    return false; 
  }
}

boolean checkForSmallFish()
{
  println("DO WE WANT SMALL FISH?" + config.wantSmallFish);
  //println("Checking for small fish...");
  if(config.wantSmallFish == false)
  {
    println("We do not want small fish...");
    return false; 
  }
  
  boolean posCheck = scanImageForColour(config.catchSmallFishBoxA, config.lightWhite, config.darkWhite);
  boolean negCheck = !scanImageForColour(config.catchSmallFishBoxB, config.lightWhite, config.darkWhite);
  
  if(posCheck && negCheck)
  {
    //println("We want this small fish!");
    return true;
  }
  else
  {
      //println("Not a small fish...");
    return false; 
  }
  
}

boolean checkForBigFish()
{
  //println("Checking for big fish...");
  if(config.wantBigFish == false)
  {
    //println("We do not want big fish...");
    return false; 
  }
  
  boolean posCheck = scanImageForColour(config.catchBigFishBoxA, config.lightWhite, config.darkWhite);
  boolean negCheck = !scanImageForColour(config.catchBigFishBoxB, config.lightWhite, config.darkWhite);
  
  if(posCheck && negCheck)
  {
    //println("We want this big fish!");
    return true;
  }
  else
  {
    //println("Not a Big Fish");
    return false; 
  }
  
}

boolean checkForEpicCatch()
{
  if(config.wantBigFish == false)
  {
    //println("We do not want big fish...");
    return false; 
  }
  
  boolean posCheck = scanImageForColour(config.epicCatchBoxA, config.lightWhite, config.darkWhite);
  boolean negCheck = !scanImageForColour(config.epicCatchBoxB, config.lightWhite, config.darkWhite);
  
  if(posCheck && negCheck)
  {
    //println("We want this big fish!");
    return true;
  }
  else
  {
    //println("Not a Big Fish");
    return false; 
  }
  
}

boolean checkForItem()
{
  println("DO WE WANT SMALL FISH?" + config.wantSmallFish);
  //println("Checking for small fish...");
  if(config.wantItem == false)
  {
    println("We do not want items...");
    return false; 
  }
  
  boolean posCheck = scanImageForColour(config.catchItemBoxA, config.lightWhite, config.darkWhite);
  boolean negCheck = !scanImageForColour(config.catchItemBoxB, config.lightWhite, config.darkWhite);
  
  if(posCheck && negCheck)
  {
    //println("We want this small fish!");
    return true;
  }
  else
  {
      //println("Not a small fish...");
    return false; 
  }
  
}


boolean checkIfReadyToCast()
{
  keyPresser.pressAlt();
  delay(1250);
  PImage img = grabScreenshot(screenshot, dimension, robot);
  image(img, 0, 0, width, height);
  if(scanImageForColour(config.macroPaletteBox, config.lightWhite, config.darkWhite))
  {
    keyPresser.releaseAlt();
    println("READY TO CAST");
    return true; 
  }
  else
  {
    keyPresser.releaseAlt();
    println("NOT READY TO CAST");
    return false;
  }
}


static final PImage grabScreenshot(PImage img, Rectangle dim, Robot bot) { 
  bot.createScreenCapture(dim).getRGB(0, 0
    , dim.width, dim.height
    , img.pixels, 0, dim.width);
 
  img.updatePixels();
  return img;
}

void drawBox(int[] box)
{
  rect(box[0], box[1], box[2], box[3]);
}

void setState(int value)
{
  config.state = value;
}

int getState()
{
  return config.state; 
}

int getDelay(int low, int high)
{
  int randDelay = int(round(random(low, high)));
  return randDelay; 
}

void checkForTells()
{
  PImage chatLogAnalysisImg = grabScreenshot(screenshot, dimension, robot);
  image(chatLogAnalysisImg, 0, 0, width, height);
  drawBox(config.leftChatBox);
  drawBox(config.rightChatBox);
  if( scanImageForColour(config.leftChatBox, config.lightPink, config.darkPink) || scanImageForColour(config.rightChatBox, config.lightPink, config.darkPink))
  {
    println("Alert! Alert! Alert!");
  }
}

void begin()
{
  setState(0);
}

void quit()
{
  setState(-1);
}
