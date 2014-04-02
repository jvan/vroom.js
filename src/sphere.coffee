_sphere =
   initialized: false
   vao: undefined
   vbo:
      vertex: undefined
      normal: undefined
   ibo: undefined

init_sphere = (gl) ->
   console.log '[init_sphere]'

   lat_bands = 25
   lon_bands = 25

   radius = 0.5

   vertex_data = []
   normal_data = []

   for lat in [0..lat_bands]
      theta = lat * Math.PI / lat_bands
      sin_theta = Math.sin theta
      cos_theta = Math.cos theta

      for lon in [0..lon_bands]
         phi = lon * 2.0 * Math.PI / lon_bands
         sin_phi = Math.sin phi
         cos_phi = Math.cos phi

         x = cos_phi * sin_theta
         y = cos_theta
         z = sin_phi * sin_theta

         normal_data.push(x)
         normal_data.push(y)
         normal_data.push(z)

         vertex_data.push(radius * x)
         vertex_data.push(radius * y)
         vertex_data.push(radius * z)

   index_data = []

   for lat in [0...lat_bands]
      for lon in [0...lon_bands]
         first = (lat * (lon_bands + 1)) + lon
         second = first + lon_bands + 1

         index_data.push(first)
         index_data.push(second)
         index_data.push(first + 1)

         index_data.push(second)
         index_data.push(second + 1)
         index_data.push(first + 1)

   _sphere.vao = new ArrayBuffer

   _sphere.vbo.vertex = new VertexBuffer new Float32Array(vertex_data)
   vroom.program.attribLoc('position').attribArray 3, gl.FLOAT, 0, 0

   _sphere.vbo.normal = new VertexBuffer new Float32Array(normal_data)
   vroom.program.attribLoc('normal').attribArray 3, gl.FLOAT, 0, 0

   _sphere.ibo = new IndexBuffer new Uint16Array(index_data)

   _sphere.initialized = true

sphere = (style='wireframe') ->
   gl = State.get().gl
   init_sphere(gl) if not _sphere.initialized

   _sphere.vao.bind()
   _sphere.ibo.bind()

   if style == 'wireframe'
      gl.drawElements gl.LINE_STRIP, _sphere.ibo.count(), gl.UNSIGNED_SHORT, 0
   else if  style == 'solid'
      gl.drawElements gl.TRIANGLES, _sphere.ibo.count(), gl.UNSIGNED_SHORT, 0

   _sphere.ibo.protect()
   _sphere.vao.protect()


# Exports

window.sphere = sphere

