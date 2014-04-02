_shapes =
   initialized: false
   vao: undefined
   vbo: undefined
   ibo:
      triangle: undefined
      square: undefined

init_shapes = (gl) ->
   console.log '[init_shapes]'

   shapes =
      vertex_data: new Float32Array [
         -0.5, -0.5, 0,  0, 0, 1,
         -0.5,  0.5, 0,  0, 0, 1,
          0.0, -0.5, 0,  0, 0, 1,
          0.0,  0.5, 0,  0, 0, 1,
          0.5, -0.5, 0,  0, 0, 1,
          0.5,  0.5, 0,  0, 0, 1
      ]

      index_data:
         triangle: new Uint8Array [ 0, 3, 4 ]

         square: new Uint8Array [
            0, 1, 4,
            1, 4, 5
         ]
   
   _shapes.vao = new ArrayBuffer gl

   _shapes.vbo = new VertexBuffer gl, shapes.vertex_data

   stride = _shapes.vbo.offset 6
   offset =
      pos:  _shapes.vbo.offset 0
      norm: _shapes.vbo.offset 3

   vroom.program.attribLoc('position').attribArray 3, gl.FLOAT, stride, offset.pos
   vroom.program.attribLoc('normal').attribArray 3, gl.FLOAT, stride, offset.norm

   _shapes.ibo.triangle = new IndexBuffer gl, shapes.index_data.triangle
   _shapes.ibo.square = new IndexBuffer gl, shapes.index_data.square

   _shapes.initialized = true


draw_shape = (gl, ibo) ->
   _shapes.vao.bind()
   ibo.bind()
   
   gl.drawElements gl.TRIANGLES, ibo.count(), gl.UNSIGNED_BYTE, 0

   ibo.protect()
   _shapes.vao.protect()

triangle = (gl) ->
   init_shapes(gl) if not _shapes.initialized

   draw_shape gl, _shapes.ibo.triangle

square = (gl) ->
   init_shapes(gl) if not _shapes.initialized

   draw_shape gl, _shapes.ibo.square


# Exports

window.triangle = triangle
window.square = square
