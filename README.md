# PGouraudShading
Gouraud shading implementation. Written in Processing language which is based on Java.

![alt text](https://github.com/alwayzmile/PGouraudShading/blob/master/screenshot.png "Screenshots")

##Features:
This work originally comes from my programming assignment with the following task which will describe its main features.
Create an application that simulates the shading of a sphere. The sphere originally is centered at (0, 0, 0) and has a radius of 1.
By default, an perspective projection at z=0 plane with one vanishing point at (0,0,-5) is used for the view; when the program runs, a circle should be seen. There is a light source, by default at (-10, -10, 10).
The program must be able to:
* Translate the sphere on the x, y, and z axes. 
* Perform a back face culling on the sphere.
* Illuminate the sphere using Gouraud shading. Include ambient, diffuse, and specular lighting.
* Allow the user to change the diffuse, ambient, and specular coefficient of the sphere.
* Allow the user to change the specular reflection exponent of the sphere.
* Move the light source to another location.
* Add another light source

##Development:
* [Processing 2.2.1](https://processing.org/) - Work in Processing 3.0 as well
* [controlP5-2.2.5](http://www.sojamo.de/libraries/controlP5/) - Processing library for user interface
