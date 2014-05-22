function init() {
   data = read_file('/data/earthquakes-2010.dat');
   lines = data.split('\n').slice(2)

   points = [];
   colors = [];

   globals.center = { x: 0.0, y: 0.0, z: 0.0 };

   for (var i=0; i<lines.length; i++) {
      if (lines[i] == '') continue;

      elems = lines[i].split('  ');
      latlon = elems[1].split(' ');

      lat = parseFloat(latlon[0]);
      lon = parseFloat(latlon[1]);
      depth = parseFloat(elems[2]);
      
      points.push([lon, lat, depth]);
      colors.push([0, 1, 0]);

      globals.center.x += lon;
      globals.center.y += lat;
      globals.center.z += depth;
   }

   globals.center.x /= (points.length);
   globals.center.y /= (points.length);
   globals.center.z /= (points.length);

   for (var i=0; i<points.length; i++) {
      points[i][0] -=  globals.center.x;
      points[i][1] -=  globals.center.y;
      points[i][2] -=  globals.center.z;
   }

   globals.earthquakes = new PointCloud(points, colors);

   background(0.2, 0.2, 0.2);
}

function display() {
   lighting(false);

   globals.earthquakes.draw();
}
