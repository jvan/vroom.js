function init() {
   background(0.2, 0.2, 0.2);

   num_points = 5000

   points = random_positions(num_points, -15.0, 15.0);
   colors = random_colors(num_points);

   globals.point_cloud = new PointCloud(points, colors);
}

function display() {
   lighting(false);

   globals.point_cloud.draw();
}

