function init() {
   background(0.2, 0.2, 0.2);

   globals.num_cubes  = 250;
   globals.cubes = [];

   for (var i=0; i<globals.num_cubes; i++) {
      globals.cubes.push({
         pos: random_position(-15, 15),
         col: random_color(),
         vel: rand(0.05, 0.1)
      });
   }
}

function frame() {
   globals.cubes.forEach(function(block) {
      block.pos[0] += block.vel;
      block.pos[0] = block.pos[0] > 15.0 ? -15.0 : block.pos[0];
   });
}

function display() {
   lighting(true);

   scale(0.25, 0.25, 0.25);

   globals.cubes.forEach(function(block) {
      translate(block.pos);
      color(block.col);
      cube('solid');
      translate(block.pos.map(function(x) { return -x; }));
   });
}

