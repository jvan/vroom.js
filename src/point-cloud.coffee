_point_cloud =
   initialized: false
   program: undefined

init_point_cloud = (gl) ->
   console.log '[init_point_cloud]'

   shaders = glsw.load_shaders '/shaders/point-cloud.glsl'
   _point_cloud.program = new Program shaders.vertex, shaders.fragment
   _point_cloud.initialized = true

class PointCloud
   constructor: (vertex_data, color_data) ->
      console.log '[PointCloud.constructor]'

      @gl = State.get().gl

      init_point_cloud @gl if not _point_cloud.initialized

      @_vao = new ArrayBuffer()

      vertices = [].concat.apply([], vertex_data)
      colors = [].concat.apply([], color_data)

      @_buffer =
         vertex: new VertexBuffer new Float32Array(vertices)
         color:  new VertexBuffer new Float32Array(colors)

      _point_cloud.program.use()

      @_buffer.vertex.bind()
      _point_cloud.program.attribLoc('position').attribArray 3, @gl.FLOAT, 0, 0
      #vroom.program.attribLoc('position').attribArray 3, @gl.FLOAT, 0, 0

      @_buffer.color.bind()
      _point_cloud.program.attribLoc('color').attribArray 3, @gl.FLOAT, 0, 0
      #vroom.program.attribLoc('color').attribArray 3, @gl.FLOAT, 0, 0

      @_count = vertices.length / 3

      #vroom.set_program _point_cloud.program

   draw: () ->
      _point_cloud.program.use()

      @_vao.bind()

      _point_cloud.program.uniformLoc('view').mat4f matrix.view
      _point_cloud.program.uniformLoc('proj').mat4f matrix.proj

      mat4.identity matrix.model

      angle = State.get().current_angle
      mat4.rotateX matrix.model, matrix.model, radians(angle[0])
      mat4.rotateY matrix.model, matrix.model, radians(angle[1])
      _point_cloud.program.uniformLoc('model').mat4f matrix.model

      @gl.drawArrays @gl.POINTS, 0, @_count


# Exports

window.PointCloud = PointCloud
