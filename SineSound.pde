import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import controlP5.*;

import tactu5.*;

class SineSound implements Instrument
{
  
  Oscil wave;
  Line ampEnv;
  
  SineSound(float freq)
  {
    wave = new Oscil(freq, 0, Waves.SINE);
    ampEnv = new Line();
    ampEnv.patch(wave.amplitude);
  }
  
  void noteOn(float duration)
  {
    ampEnv.activate(duration, 0.5f, 0);
    wave.patch(output);
  }
  
  void noteOff()
  {
    wave.unpatch(output);
  }
  
}