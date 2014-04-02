attribute vec4 position;
attribute vec4 normal;

uniform mat4 model;
uniform mat4 view;
uniform mat4 proj;

mat4 transform = proj * view * model;

uniform vec3 color;
varying vec3 v_color;

struct Light {
   vec3 direction;
   vec3 color;
   vec3 ambient; 
   int enabled;
};

uniform Light light;

uniform mat4 normalMatrix;


void main() {
   gl_Position = transform * position;
   gl_PointSize = 5.0;

   if (light.enabled == 1) {
      vec3 norm = normalize(vec3(normalMatrix * normal));

      float nDotL = max(dot(light.direction, norm), 0.0);
      vec3 diffuse = light.color * color * nDotL;
      vec3 ambient = light.ambient * color;

      v_color = diffuse + ambient;
   } else {
      v_color = color;
   }
}

