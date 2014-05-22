function lorenz(t, pos) {
   var sigma = 10.0, beta = 8.0/3.0, rho = 28.0;
   var x = pos[0], y = pos[1], z = pos[2];
   return [sigma*(y-x), x*(rho-z)-y, x*y-beta*z]; 
}

function init() {
   pos = [-1, 3, 4];
   soln = numeric.dopri(0, 20, pos, lorenz, 1e-6, 2000);   

   points = [], colors = [];

   for (var i=0; i<soln.x.length; i++) {
      points.push(soln.y[i]);
      colors.push(orange);
   }

   globals.path = new PointCloud(points, colors);
}


function display() {
   lighting(false);
   color(green);
   globals.path.draw();
}
