window.globals = { }

class State
   _instance = null

   class Singleton
      constructor: ->
         console.log '[State.constructor]'
         @gl = undefined
         @matrix =
            normal = undefined

         @current_angle = [0, 0]

   @get: ->
      _instance ?= new Singleton

   @gl: ->
      @get().gl

vroom =
   program: undefined
   set_program: (prog) ->
      vroom.program = prog

matrix =
   model: mat4.create()
   view:  mat4.create()
   proj:  mat4.create()
   norm:  mat4.create()

background = (r, g, b, a=1.0) ->
   gl = State.gl()
   gl.clearColor r, g, b, a


_process_color_args  = (args) ->
   if args.length == 1
      if typeof(args[0]) == 'number'
         return [args[0], args[0], args[0]]
      else
         return args[0]
   else
      return [args[0], args[1], args[2]]

color = ->
   args = _process_color_args arguments
   #console.log '[color]: args=' + args
   vroom.program.uniformLoc('color').vec3f args


lighting = (enabled) ->
   state =if enabled then 1 else 0
   vroom.program.uniformLoc('light.enabled').vec1i state


# Exports

window.background = background
window.color = color
window.lighting = lighting

window.red    = [1, 0, 0]
window.green  = [0, 1, 0]
window.blue   = [0, 0, 1]

window.purple = [0.5, 0.0, 1.0]
window.orange = [1.0, 0.5, 0.0]

#exports.color_args = _process_color_args
