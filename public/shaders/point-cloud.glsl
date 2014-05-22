--- vertex

attribute vec4 position;
attribute vec4 color;

varying vec3 v_color;

uniform mat4 model;
uniform mat4 view;
uniform mat4 proj;

mat4 transform = proj * view * model;

void main() {
   gl_Position = transform * position;
   gl_PointSize = 5.0;

   v_color = color.rgb;
}

--- fragment

precision mediump float;

varying vec3 v_color;

void main() {
   float dist = distance(gl_PointCoord, vec2(0.5, 0.5));

   if (dist < 0.5) {
      gl_FragColor = vec4(v_color, 1.0);
   } else {
      discard;
   }
}
