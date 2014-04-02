function init(args) {
   background(0.1, 0.1, 0.1);
   globals.angle = 0.0;
   globals.style = args ? args.style : 'wireframe';
}

function frame() {
   globals.angle += 0.01;
   globals.angle %= 360;
}

function display() {
   var style = 'wireframe'

   if (globals.style == 'solid') {
      lighting(true);
      style = 'solid';
   }

   color(1.0);
   scale(2.0);
   rotateX(globals.angle);
   rotateY(globals.angle);
   
   cube(style);
}
