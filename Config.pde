class Config
{
  //-1 is app has just begun, 0 is idle, 1 is fishing, 2 is fighting, 3 is when finished
  int state = -1;
  
  int fishCaught = 0;
  int catchTarget = 107;
  
  boolean wantItem = false;
  boolean wantSmallFish = true;
  boolean wantBigFish = false;
  boolean wantMonster = false;
   
  //Eden Config
  
  int[] leftBox = {443, 336, 8, 8};
  int[] rightBox = {927, 336, 8, 8};
  int[] healthBox = {627, 225, 10, 5};
  
  int[] macroPaletteBox = {305, 125, 10,5};
  
  int[] catchSmallFishBoxA = {605, 633, 5, 10};  //This should have a white !
  int[] catchSmallFishBoxB = {615, 633, 5, 10};  //This should not have anything
  
  int[] catchBigFishBoxA = {615, 633, 5, 10};  //This should have a white !
  int[] catchBigFishBoxB = {625, 633, 5, 10};  //This should not have anything
 
  int[] epicCatchBoxA = {495, 635, 10, 4};  // the ...
  int[] epicCatchBoxB = {495, 632, 10, 4};  // the empty space above ...
   
  int[] catchItemBoxA = {376, 632, 4, 4};
  int[] catchItemBoxB = {395, 632, 4, 4};
   
  int[] goodFeelingPositive = {531, 648, 5, 5};  //This is conflicting with badFeeling, it's registering as a bad feeling
  int[] goodFeelingNegative = {525, 735, 5, 5};

  int[] dontKnowPositive = {1110, 735, 5,   5}; 
  int[] dontKnowNegative = {1125, 735, 5, 5};

  int[] badFeelingPositive = {1165, 735, 5, 5};
  int[] badFeelingNegative = {1345, 735, 5, 5};

  int[] terribleFeelingPositive = {1370, 735, 5, 5};
  int[] terribleFeelingNegative = {1385, 735, 5, 5};
  
  int[] leftChatBox = {140, 600, 15, 150};
  int[] rightChatBox = {660, 600, 15, 150};
   
  color lightGold = color(255, 200, 90);
  color darkGold = color(255, 190, 80);
  
  color lightSilver = color(220, 230, 240);
  color darkSilver = color(210, 225, 245);
  
  color lightRed = color(255, 155, 155);
  color darkRed = color(255, 150, 150);
  
  color lightWhite = color (255, 255, 255);
  color darkWhite = color (200, 207, 211);
  
  color lightPink = color(255, 138, 255);
  color darkPink = color(255, 132, 255);
  
}