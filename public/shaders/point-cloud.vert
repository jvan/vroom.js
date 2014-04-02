attribute vec4 position;
attribute vec4 color;

varying vec3 v_color;

uniform mat4 model;
uniform mat4 view;
uniform mat4 proj;

mat4 transform = proj * view * model;

void main() {
   gl_Position = transform * position;
   gl_PointSize = 5.0 + 5.0 * color.g;

   v_color = color.rgb;
}

