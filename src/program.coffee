String::startswith = (s) ->
   this.match("^#{s}") != null

_read_file = (filename) ->
   source = undefined
   $.ajax({
      async: false,
      url: filename,
      success: (result) ->
         source = result
   })
   return source

_nested_object = (base, keys, value=null) ->
   if keys.length == 1
      base[keys[0]] = value
   else
      last = keys.pop()
      for key in keys
         base = base[key] = base[key] || {}

      base[last] = value if value

glsw =
   _delimiter: '---'
   load_shaders: (filename) ->
      data = _read_file  filename
      lines = data.split '\n'

      _shaders = { }

      [keys, buffer] = [null, []]

      for line in lines
         if line.startswith glsw._delimiter
            if keys
               _nested_object _shaders, keys, buffer.join('\n')
               buffer = []
            keys = line.split(glsw._delimiter+' ')[1].split('.')
         else
            buffer.push line

      _nested_object _shaders, keys, buffer.join('\n')

      return _shaders

create_shader = (gl, source, type) ->

   if type == 'vert'
      shader = gl.createShader gl.VERTEX_SHADER
   else if type == 'frag'
      shader = gl.createShader gl.FRAGMENT_SHADER
   else
      return null

   gl.shaderSource shader, source
   gl.compileShader shader

   if not gl.getShaderParameter shader, gl.COMPILE_STATUS
      console.log gl.getShaderInfoLog shader
      return null

   return shader

class Location
   constructor: (loc) ->
      @gl = State.get().gl
      @_loc = loc

class UniformLocation extends Location
   vec1i: (a) ->
      @gl.uniform1i @_loc, a

   vec2f: () ->
      if arguments.length == 1
         @gl.uniform2fv @_loc, arguments[0]
      else
         @gl.uniform2f @_loc, arguments[0], arguments[1]

   vec3f: () ->
      if arguments.length == 1
         @gl.uniform3fv @_loc, arguments[0]
      else
         @gl.uniform3f @_loc, arguments[0], arguments[1], arguments[2]

   vec4f: () ->
      if arguments.length == 1
         @gl.uniform4fv @_loc, arguments[0]
      else
         @gl.uniform4f @_loc, arguments[0], arguments[1], arguments[2], arguments[3]

   mat4f: (mat) ->
      @gl.uniformMatrix4fv @_loc, false, mat

class AttribLocation extends Location
   enable: ->
      @gl.enableVertexAttribArray @_loc

   vec2f: ->
      if arguments.length == 1
         @gl.vertexAttrib2fv @_loc, arguments[0]
      else
         @gl.vertexAttrib2f @_loc, arguments[0], arguments[1]

   vec3f: ->
      if arguments.length == 1
         @gl.vertexAttrib3fv @_loc, arguments[0]
      else
         @gl.vertexAttrib3f @_loc, arguments[0], arguments[1], arguments[2]

   attribArray: (size, type, stride, offset) ->
      @enable()
      @gl.vertexAttribPointer @_loc, size, type, false, stride, offset

class Program
   constructor: (shader_file) ->
      shaders = glsw.load_shaders shader_file
      @gl = State.get().gl
      
      vertexShader = create_shader @gl, shaders.vertex, 'vert'
      fragmentShader = create_shader @gl, shaders.fragment, 'frag'

      @_program = @gl.createProgram()
      @gl.attachShader @_program, vertexShader
      @gl.attachShader @_program, fragmentShader
      @gl.linkProgram @_program

      if not @gl.getProgramParameter @_program, @gl.LINK_STATUS
         alert "Could not initialize shaders."

   use: ->
      @gl.useProgram @_program

   protect: ->
      @gl.useProgram null

   loc: (type, name) ->
      if type == 'uniform'
         @gl.getUniformLocation @_program, name
      if type == 'attrib'
         @gl.getAttribLocation @_program, name

   attribLoc: (name) ->
      loc = @gl.getAttribLocation @_program, name
      if loc == -1
         console.log '[Program.attribLoc]: error location not found (' +  name + ')'

      new AttribLocation loc

   uniformLoc: (name) ->
      loc = @gl.getUniformLocation @_program, name
      if loc == -1
         console.log '[Program.uniformLoc]: error location not found (' +  name + ')'

      new UniformLocation loc
   
window.Program = Program
window.AttribLocation = AttribLocation
window.UniformLocation = UniformLocation

window.glsw = glsw

window.read_file = _read_file
