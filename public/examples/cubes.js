function init() {
   background(0.2, 0.2, 0.2);

   globals.num_cubes  = 250;
   globals.positions = random_positions(globals.num_cubes, -15.0, 15.0);
   globals.colors = random_colors(globals.num_cubes);
   globals.velocities = random_values(globals.num_cubes, 0.05, 0.1);
}

function frame() {
   for (var i=0; i<globals.num_cubes; i++) {
      globals.positions[i][0] += globals.velocities[i];
      if (globals.positions[i][0] > 15.0) {
         globals.positions[i] = random_position(-15.0, 15.0);
         globals.positions[i][0] = -15.0;
      }
   }
}

function display() {
   lighting(true);

   scale(0.25, 0.25, 0.25);

   for (var i=0; i<globals.num_cubes; i++) {
      var t = globals.positions[i];
      var c = globals.colors[i];

      translate(t[0], t[1], t[2]);
      color(c[0], c[1], c[2]);

      cube('solid');

      translate(-t[0], -t[1], -t[2]);
   }
}

