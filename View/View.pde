import oscP5.*;
import netP5.*;

/* Setting OscP5 instances for different Ports*/
OscP5 oscv1;
OscP5 oscv2;
OscP5 oscv3;
OscP5 oscv4;
OscP5 oscs1;
OscP5 oscs2;
OscP5 oscs3;
OscP5 oscs4;
OscP5 oscs5;
OscP5 oscs6;

/*************Setting Ports***********/
int v1Port = 7402;
int v2Port = 7404;
int v3Port = 7406;
int v4Port = 7408;
int s1Port = 7410;
int s2Port = 7412;
int s3Port = 7414;
int s4Port = 7416;
int s5Port = 7418;
int s6Port = 7420;


/**** Making matrices ***/
float[] v1;
float[] v2;
float[] v3;
float[] v4;
float[] s1;
float[] s2;
float[] s3;
float[] s4;
float[] s5;
float[] s6;

int v1NumOfAgents;
int v2NumOfAgents;
int v3NumOfAgents;
int v4NumOfAgents;
int s1NumOfAgents;
int s2NumOfAgents;
int s3NumOfAgents;
int s4NumOfAgents;
int s5NumOfAgents;
int s6NumOfAgents;

//String Host_Ip = "127.0.0.1";
int videox = 320;
int videoy = 240;
int xmax; //2*videox + 20
int ymax; //2*videoy + 20
int i, j;
//float x, y;
int spacing=10; //Spacing for depiction
color agent, median, input; //Colors of agents and inputs
int NumOfAgents, NumOfInputs;
boolean flag;
void setup() {
  xmax = 2*videox+2*spacing;
  ymax = 2*videoy+2*spacing;
  NumOfInputs = 5;
  NumOfAgents = 30;  
  size(xmax, ymax);
  frameRate(30);

  agent = color(0, 0, 255);
  median = color(0, 255, 0);
  input = color(255, 0, 0);

  v1 = new float[2*25+4]; // Maximum size is:
  v2 = new float[2*25+4]; // 2*NumOfAgents + 2*Input +2*Median + 1
  v3 = new float[2*25+4]; //
  v4 = new float[2*25+4]; // 2* is for axes x,y
  s1 = new float[2*25+4];
  s2 = new float[2*25+4];
  s3 = new float[2*25+4];
  s4 = new float[2*25+4];
  s5 = new float[2*25+4];
  s6 = new float[2*25+4];

  /* start oscP5, listening for incoming messages at port 7402 */
  oscv1 = new OscP5(this, v1Port);
  oscv2 = new OscP5(this, v2Port);
  oscv3 = new OscP5(this, v3Port);
  oscv4 = new OscP5(this, v4Port);
  oscs1 = new OscP5(this, s1Port);
  oscs2 = new OscP5(this, s2Port);
  oscs3 = new OscP5(this, s3Port);
  oscs4 = new OscP5(this, s4Port);
  oscs5 = new OscP5(this, s5Port);
  oscs6 = new OscP5(this, s6Port);
}


void oscEvent(OscMessage message) {
  /* Initializing */
  if (message.get(0).floatValue() == v1Port) {
    v1Port = message.netAddress().port();
    v1NumOfAgents = int(message.get(1).floatValue());
    println("New port is: ", v1Port, " NumOfAgents is: ", v1NumOfAgents);
  }
  if (message.get(0).floatValue() == v2Port) {
    v2Port = message.netAddress().port();
    v2NumOfAgents = int(message.get(1).floatValue());
    println("New port is: ", v2Port, " NumOfAgents is: ", v2NumOfAgents);
  }
  if (message.get(0).floatValue() == v3Port) {
    v3Port = message.netAddress().port();
    v3NumOfAgents = int(message.get(1).floatValue());
    println("New port is: ", v3Port, " NumOfAgents is: ", v3NumOfAgents);
  }
  if (message.get(0).floatValue() == v4Port) {
    v4Port = message.netAddress().port();
    v4NumOfAgents = int(message.get(1).floatValue());
    println("New port is: ", v4Port, " NumOfAgents is: ", v4NumOfAgents);
  }
  if (message.get(0).floatValue() == s1Port) {
    s1Port = message.netAddress().port();
    s1NumOfAgents = int(message.get(1).floatValue());
    println("New port is: ", s1Port, " NumOfAgents is: ", s1NumOfAgents);
  }
  if (message.get(0).floatValue() == s2Port) {
    s2Port = message.netAddress().port();
    s2NumOfAgents = int(message.get(1).floatValue());
    println("New port is: ", s2Port, " NumOfAgents is: ", s2NumOfAgents);
  }
  if (message.get(0).floatValue() == s3Port) {
    s3Port = message.netAddress().port();
    s3NumOfAgents = int(message.get(1).floatValue());
    println("New port is: ", s3Port, " NumOfAgents is: ", s3NumOfAgents);
  }
  if (message.get(0).floatValue() == s4Port) {
    s4Port = message.netAddress().port();
    s4NumOfAgents = int(message.get(1).floatValue());
    println("New port is: ", s4Port, " NumOfAgents is: ", s4NumOfAgents);
  }
  if (message.get(0).floatValue() == s5Port) {
    s5Port = message.netAddress().port();
    s5NumOfAgents = int(message.get(1).floatValue());
    println("New port is: ", s5Port, " NumOfAgents is: ", s5NumOfAgents);
  }
  if (message.get(0).floatValue() == s6Port) {
    s6Port = message.netAddress().port();
    s6NumOfAgents = int(message.get(1).floatValue());
    println("New port is: ", s6Port, " NumOfAgents is: ", s6NumOfAgents);
  }
  if (message.netAddress().port() == v1Port) {
    for ( j = 2; j < 2*v1NumOfAgents+4+2; j++) {
      v1[j-2] = message.get(j).floatValue();
    }
  }
  if (message.netAddress().port() == v2Port) {
    for ( j = 2; j < 2*v2NumOfAgents+4+2; j++) {
      v2[j-2] = message.get(j).floatValue();
    }
  }
  if (message.netAddress().port() == v3Port) {
    for ( j = 2; j < 2*v3NumOfAgents+4+2; j++) {
      v3[j-2] = message.get(j).floatValue();
    }
  }
    if (message.netAddress().port() == v4Port) {
    for ( j = 2; j < 2*v4NumOfAgents+4+2; j++) {
      v4[j-2] = message.get(j).floatValue();
    }
  }
  if (message.netAddress().port() == s1Port) {
    for ( j = 2; j < 2*s1NumOfAgents+4+2; j++) {
      s1[j-2] = message.get(j).floatValue();
    }
  }
  if (message.netAddress().port() == s2Port) {
    for ( j = 2; j < 2*s2NumOfAgents+4+2; j++) {
      s2[j-2] = message.get(j).floatValue();
    }
  }
  if (message.netAddress().port() == s3Port) {
    for ( j = 2; j < 2*s3NumOfAgents+4+2; j++) {
      s3[j-2] = message.get(j).floatValue();
    }
  }
  if (message.netAddress().port() == s4Port) {
    for ( j = 2; j < 2*s4NumOfAgents+4+2; j++) {
      s4[j-2] = message.get(j).floatValue();
    }
  }
  if (message.netAddress().port() == s5Port) {
    for ( j = 2; j < 2*s5NumOfAgents+4+2; j++) {
      s5[j-2] = message.get(j).floatValue();
    }
  }
  if (message.netAddress().port() == s6Port) {
    for ( j = 2; j < 2*s6NumOfAgents+4+2; j++) {
      s6[j-2] = message.get(j).floatValue();
    }
  }

}

float[] t;


void draw() {
  background(255);
  /*********** Background Lines **********/
/*  for ( i = 10; i < xmax; i = i+spacing) {
    line(i, 10, i, ymax-10);
  }   
  for ( i = 10; i < ymax; i = i+spacing) {
    line(10, i, xmax-10, i);
  }
*/
  /************** Agents *********************/
  fill(agent);

  for (i = 4 ; i < 2*v1NumOfAgents+4 ; i=i+2) {
    ellipse(v1[i]+videox/2+spacing, (240-v1[i+1])+videoy/2+spacing, spacing/2, spacing/2);
  }
  for (i = 4 ; i < 2*v2NumOfAgents+4 ; i=i+2) {
    ellipse(v2[i]+videox/2+spacing, v2[i+1]+videoy/2+spacing, spacing/2, spacing/2);
  }
  for (i = 4 ; i < 2*v3NumOfAgents+4 ; i=i+2) {
    ellipse(v3[i]+videox/2+spacing, v3[i+1]+videoy/2+spacing, spacing/2, spacing/2);
  }
  for (i = 4 ; i < 2*v4NumOfAgents+4 ; i=i+2) {
    ellipse(v4[i]+videox/2+spacing, v4[i+1]+videoy/2+spacing, spacing/2, spacing/2);
  }
  for (i = 4 ; i < 2*s1NumOfAgents+4 ; i=i+2) {
    ellipse(s1[i]+videox/2+spacing, s1[i+1]+videoy/2+spacing, spacing/2, spacing/2);
  }
  for (i = 4 ; i < 2*s2NumOfAgents+4 ; i=i+2) {
    ellipse(s2[i]+videox/2+spacing, s2[i+1]+videoy/2+spacing, spacing/2, spacing/2);
  }
  for (i = 4 ; i < 2*s3NumOfAgents+4 ; i=i+2) {
    ellipse(s3[i]+videox/2+spacing, s3[i+1]+videoy/2+spacing, spacing/2, spacing/2);
  }
  for (i = 4 ; i < 2*s4NumOfAgents+4 ; i=i+2) {
    ellipse(s4[i]+videox/2+spacing, s4[i+1]+videoy/2+spacing, spacing/2, spacing/2);
  }
  for (i = 4 ; i < 2*s5NumOfAgents+4 ; i=i+2) {
    ellipse(s5[i]+videox/2+spacing, s5[i+1]+videoy/2+spacing, spacing/2, spacing/2);
  }
  for (i = 4 ; i < 2*s6NumOfAgents+4 ; i=i+2) {
    ellipse(s6[i]+videox/2+spacing, s6[i+1]+videoy/2+spacing, spacing/2, spacing/2);
  }

  /****** Median*******/
  fill(median);
  if (v1NumOfAgents != 0) {
    ellipse(v1[2]+videox/2+spacing, (240-v1[3])+videoy/2+spacing, spacing/2, spacing/2);
  }
  if (v2NumOfAgents != 0) {
    ellipse(v2[2]+videox/2+spacing, v2[3]+videoy/2+spacing, spacing/2, spacing/2);
  }
  if (v3NumOfAgents != 0) {
    ellipse(v3[2]+videox/2+spacing, v3[3]+videoy/2+spacing, spacing/2, spacing/2);
  }
  if (v4NumOfAgents != 0) {
    ellipse(v4[2]+videox/2+spacing, v4[3]+videoy/2+spacing, spacing/2, spacing/2);
  }
  if (s1NumOfAgents != 0) {
    ellipse(s1[2]+videox/2+spacing, s1[3]+videoy/2+spacing, spacing/2, spacing/2);
  }
  if (s2NumOfAgents != 0) {
    ellipse(s2[2]+videox/2+spacing, s2[3]+videoy/2+spacing, spacing/2, spacing/2);
  }
  if (s3NumOfAgents != 0) {
    ellipse(s3[2]+videox/2+spacing, s3[3]+videoy/2+spacing, spacing/2, spacing/2);
  }
  if (s4NumOfAgents != 0) {
    ellipse(s4[2]+videox/2+spacing, s4[3]+videoy/2+spacing, spacing/2, spacing/2);
  }
  if (s5NumOfAgents != 0) {
    ellipse(s5[2]+videox/2+spacing, s5[3]+videoy/2+spacing, spacing/2, spacing/2);
  }
  if (s6NumOfAgents != 0) {
    ellipse(s6[2]+videox/2+spacing, s6[3]+videoy/2+spacing, spacing/2, spacing/2);
  }

  /******* Input***********/
  fill(input);

  if (v1NumOfAgents != 0) {
    ellipse(v1[0]+videox/2+spacing, (240-v1[1])+videoy/2+spacing, spacing/2, spacing/2);
  }
  if (v2NumOfAgents != 0) {
    ellipse(v2[0]+videox/2+spacing, v2[1]+videoy/2+spacing, spacing/2, spacing/2);
  }
  if (v3NumOfAgents != 0) {
    ellipse(v3[0]+videox/2+spacing, v3[1]+videoy/2+spacing, spacing/2, spacing/2);
  }
  if (v4NumOfAgents != 0) {
    ellipse(v4[0]+videox/2+spacing, v4[1]+videoy/2+spacing, spacing/2, spacing/2);
  }
  if (s1NumOfAgents != 0) {
    ellipse(s1[0]+videox/2+spacing, s1[1]+videoy/2+spacing, spacing/2, spacing/2);
  }
  if (s2NumOfAgents != 0) {
    ellipse(s2[0]+videox/2+spacing, s2[1]+videoy/2+spacing, spacing/2, spacing/2);
  }
  if (s3NumOfAgents != 0) {
    ellipse(s3[0]+videox/2+spacing, s3[1]+videoy/2+spacing, spacing/2, spacing/2);
  }
  if (s4NumOfAgents != 0) {
    ellipse(s4[0]+videox/2+spacing, s4[1]+videoy/2+spacing, spacing/2, spacing/2);
  }
  if (s5NumOfAgents != 0) {
    ellipse(s5[0]+videox/2+spacing, s5[1]+videoy/2+spacing, spacing/2, spacing/2);
  }
  if (s6NumOfAgents != 0) {
    ellipse(s6[0]+videox/2+spacing, s6[1]+videoy/2+spacing, spacing/2, spacing/2);
  }

}

