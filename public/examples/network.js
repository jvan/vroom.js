function init() {
   data = read_file('/data/miserables.json');

   points = [], colors = [];

   data.nodes.forEach(function(node) {
      //points.push({
         //pos: random_position(-1, 1),
         //name: node.name
      //});
      points.push(random_position(-1, 1));
      colors.push(green);
   });

   links = []
   data.links.forEach(function(link) {
      links.push(points[link.source]);
      links.push(points[link.target]);
   });

   //globals.nodes = new PointCloud(points, colors);
   vertices = [].concat.apply([], links)
   globals.links = new VertexBuffer(new Float32Array(vertices));

   background(0.2, 0.2, 0.2);
}

function display() {
   lighting(false);
   //globals.nodes.draw();

   color(1.0);
   globals.links.draw('lines');
}
