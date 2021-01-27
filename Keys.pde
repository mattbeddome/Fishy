class KeyPresser
{
  void pressOne()
  {
    println("Press 1");
    robot.keyPress(KeyEvent.VK_1);
    delay(int(round(random(100, 200))));
    robot.keyRelease(KeyEvent.VK_1);
    println("Release 1");
    delay(int(round(random(100, 200))));
  }
  
  void pressAlt()
  {
    println ("Press Alt");
    robot.keyPress(KeyEvent.VK_ALT);
    delay(int(round(random(200, 500))));
  }
  
  void releaseAlt()
  {
    println("Release Alt");
    robot.keyRelease(KeyEvent.VK_ALT);
    delay(int(round(random(200, 500))));
  }
  
  void pressEnter()
  {
    println("Press Enter");
    robot.keyPress(KeyEvent.VK_ENTER);
    delay(int(round(random(25, 200))));
    robot.keyRelease(KeyEvent.VK_ENTER);
  }
  
  void pressLeft()
  {
    println ("Press Left");
    robot.keyPress(KeyEvent.VK_LEFT);
    delay(int(round(random(250, 600))));
    robot.keyRelease(KeyEvent.VK_LEFT);
  }
  
  void pressRight()
  {
    println("Press Right");
    robot.keyPress(KeyEvent.VK_RIGHT);
    delay(int(round(random(250, 600))));
    robot.keyRelease(KeyEvent.VK_RIGHT);
  }
  
  void pressEsc()
  {
    println ("Press Escape");
    output.playNote(0, 0.10, new SineSound(baseTone + 987));
    robot.keyRelease(KeyEvent.VK_ALT);
    delay(int(round(random(300, 700))));
    robot.keyPress(KeyEvent.VK_ESCAPE);
    delay(int(round(random(150, 400))));
    robot.keyRelease(KeyEvent.VK_ESCAPE);
    
  }
  
}