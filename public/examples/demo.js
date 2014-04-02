function init() {
   background(0.1, 0.1, 0.1);
   globals.angle = 0.0;
   globals.axis  = [Math.random(), Math.random(), Math.random()];
}

function frame() {
   globals.angle += 0.01;
   globals.angle %= 360;
}

function display() {
   lighting(false);
   color(1.0);
   scale(2.0);
   rotate(globals.angle, globals.axis);
   cube();
}
