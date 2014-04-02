function init() {
   background(0.2, 0.2, 0.2);
}

function display() {
   lighting(true);

   translate(-1, 0, 0);
   color(orange);
   cube('solid');

   translate(2, 0, 0);
   color(0, 1, 0.5);
   cube('solid');
}

