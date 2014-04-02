_cube =
   initialized: false
   vao: undefined
   vbo:
      vertex: undefined
      normal: undefined
   ibo: undefined

init_cube = (gl) ->
   console.log '[init_cube]'

   cube =
      vertex_data: new Float32Array [
          0.5, 0.5, 0.5,  -0.5, 0.5, 0.5,  -0.5,-0.5, 0.5,   0.5,-0.5, 0.5,
          0.5, 0.5, 0.5,   0.5,-0.5, 0.5,   0.5,-0.5,-0.5,   0.5, 0.5,-0.5,
          0.5, 0.5, 0.5,   0.5, 0.5,-0.5,  -0.5, 0.5,-0.5,  -0.5, 0.5, 0.5,
         -0.5, 0.5, 0.5,  -0.5, 0.5,-0.5,  -0.5,-0.5,-0.5,  -0.5,-0.5, 0.5,
         -0.5,-0.5,-0.5,   0.5,-0.5,-0.5,   0.5,-0.5, 0.5,  -0.5,-0.5, 0.5,
          0.5,-0.5,-0.5,  -0.5,-0.5,-0.5,  -0.5, 0.5,-0.5,   0.5, 0.5,-0.5
      ]

      normal_data: new Float32Array [
          0.0, 0.0, 1.0,   0.0, 0.0, 1.0,   0.0, 0.0, 1.0,   0.0, 0.0, 1.0,
          1.0, 0.0, 0.0,   1.0, 0.0, 0.0,   1.0, 0.0, 0.0,   1.0, 0.0, 0.0,
          0.0, 1.0, 0.0,   0.0, 1.0, 0.0,   0.0, 1.0, 0.0,   0.0, 1.0, 0.0,
         -1.0, 0.0, 0.0,  -1.0, 0.0, 0.0,  -1.0, 0.0, 0.0,  -1.0, 0.0, 0.0,
          0.0,-1.0, 0.0,   0.0,-1.0, 0.0,   0.0,-1.0, 0.0,   0.0,-1.0, 0.0,
          0.0, 0.0,-1.0,   0.0, 0.0,-1.0,   0.0, 0.0,-1.0,   0.0, 0.0,-1.0
      ]

      index_data: new Uint8Array [
         0, 1, 2,   0, 2, 3,
         4, 5, 6,   4, 6, 7,
         8, 9,10,   8,10,11,
         12,13,14,  12,14,15,
         16,17,18,  16,18,19,
         20,21,22,  20,22,23
      ]

   _cube.vao = new ArrayBuffer()

   _cube.vbo.vertex = new VertexBuffer cube.vertex_data
   vroom.program.attribLoc('position').attribArray 3, gl.FLOAT, 0, 0

   _cube.vbo.normal = new VertexBuffer cube.normal_data
   vroom.program.attribLoc('normal').attribArray 3, gl.FLOAT, 0, 0
   
   _cube.ibo = new IndexBuffer cube.index_data

   _cube.initialized = true

cube = (style='wireframe') ->
   gl = State.get().gl
   init_cube(gl) if not _cube.initialized

   _cube.vao.bind()
   _cube.ibo.bind()

   if style == 'wireframe'
      gl.drawElements gl.LINE_STRIP, _cube.ibo.count(), gl.UNSIGNED_BYTE, 0
   else if style == 'solid'
      gl.drawElements gl.TRIANGLES, _cube.ibo.count(), gl.UNSIGNED_BYTE, 0

   _cube.ibo.protect()
   _cube.vao.protect()


# Exports

window.cube = cube

