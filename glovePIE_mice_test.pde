/**
Author: Benjamin Low
Date: 2 Feb 2015
Description: This program listens to a OSC port from GlovePIE that sends
data from two wiimotes acting as fake mouse cursors. The system mouse is
controlled by a real mouse while two other fake cursors are controlled by 
the wiimotes but behave as real cursors.
 */

import oscP5.*;

OscP5 oscP5;

int myListeningPort = 12000;

String mouse1_x = "/wii/cursor2_x"; //mouse 1 cursor x-pos, value of between 0 to 1
String mouse1_y = "/wii/cursor2_y";
String mouse1_leftclick = "/wii/cursor2_leftclick"; //whether left mouse button clicked, "1" or "0"
String mouse1_rightclick = "/wii/cursor2_rightclick";
String mouse2_x = "/wii/cursor3_x";
String mouse2_y = "/wii/cursor3_y";
String mouse2_leftclick = "/wii/cursor3_leftclick";
String mouse2_rightclick = "/wii/cursor3_rightclick";

int m1_x, m1_y, m2_x, m2_y;
int m1_leftclick, m1_rightclick, m2_leftclick, m2_rightclick;

void setup() {
    size(displayWidth, displayHeight);
    oscP5 = new OscP5(this, myListeningPort);
    background(0);
    frameRate(25);
}

void draw() {
    
    if (m1_leftclick == 1) {
        fill(255,0,0);
         ellipse(m1_x*width/127.0, m1_y*height/127.0, 30, 30);   
   }
    
    if (m2_leftclick == 1) {
        fill(0,255,0);
        ellipse(m2_x*width/127.0, m2_y*height/127.0, 30, 30);
    }
    
    if (m1_rightclick == 1 || m2_rightclick == 1) {
         background(0);   
    }
}

void oscEvent(OscMessage theOscMessage) {
    /* check if the address pattern fits any of our patterns */
    /*
       print("\nreceived an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());
  println();
 */
 
    String the_value = "";
    
    if (theOscMessage.addrPattern().equals(mouse1_x)) {
        if (theOscMessage.typetag().equals("i")) {
        m1_x = theOscMessage.get(0).intValue(); 
        the_value = str(m1_x);
        //println(theOscMessage.addrPattern() + ": " + the_value);
        }
        
    } 
    else if (theOscMessage.addrPattern().equals(mouse1_y)) {
         if (theOscMessage.typetag().equals("i")) {
        m1_y = theOscMessage.get(0).intValue(); 
        the_value = str(m1_y);
        //println(theOscMessage.addrPattern() + ": " + the_value);
         }
    } 
    else if (theOscMessage.addrPattern().equals(mouse2_x)) {
        m2_x = theOscMessage.get(0).intValue();
        the_value = str(m2_x);
    } 
    else if (theOscMessage.addrPattern().equals(mouse2_y)) {
        m2_y = theOscMessage.get(0).intValue();
        the_value = str(m2_y);
    } 
    else if (theOscMessage.addrPattern().equals(mouse1_leftclick)) {
        m1_leftclick = theOscMessage.get(0).intValue();
        the_value = str(m1_leftclick);
    } 
    else if (theOscMessage.addrPattern().equals(mouse1_rightclick)) {
        m1_rightclick = theOscMessage.get(0).intValue();
        the_value = str(m1_rightclick);
    } 
    else if (theOscMessage.addrPattern().equals(mouse2_leftclick)) {
        m2_leftclick = theOscMessage.get(0).intValue();
        the_value = str(m2_leftclick);
    } 
    else if (theOscMessage.addrPattern().equals(mouse2_rightclick)) {
        m2_rightclick = theOscMessage.get(0).intValue();
        the_value = str(m2_rightclick);
    }
    
    
    //println(theOscMessage.addrPattern() + ": " + the_value);
}

boolean sketchFullScreen() {
  return true;
}
