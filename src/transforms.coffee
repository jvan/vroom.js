update_normal_matrix = ->
   mat4.identity matrix.norm
   mat4.invert matrix.norm, matrix.model
   mat4.transpose matrix.norm, matrix.norm
   vroom.program.uniformLoc('normalMatrix').mat4f matrix.norm


_vector_args = (args) ->
   if args.length == 3
      return vec3.fromValues args[0], args[1], args[2]
   return vec3.fromValues args[0][0], args[0][1], args[0][2]

translateX = (tx) ->
   mat4.translate matrix.model, matrix.model, [tx, 0, 0]
   vroom.program.uniformLoc('model').mat4f matrix.model
   update_normal_matrix()

translateY = (ty) ->
   mat4.translate matrix.model, matrix.model, [0, ty, 0]
   vroom.program.uniformLoc('model').mat4f matrix.model
   update_normal_matrix()

translateZ = (tz) ->
   mat4.translate matrix.model, matrix.model, [0, 0, tz]
   vroom.program.uniformLoc('model').mat4f matrix.model
   update_normal_matrix()

translate = ->
   args = _vector_args arguments
   mat4.translate matrix.model, matrix.model, args
   vroom.program.uniformLoc('model').mat4f matrix.model
   update_normal_matrix()


rotateX = (angle) ->
   mat4.rotate matrix.model, matrix.model, angle, [1, 0, 0]
   vroom.program.uniformLoc('model').mat4f matrix.model
   update_normal_matrix()

rotateY = (angle) ->
   mat4.rotate matrix.model, matrix.model, angle, [0, 1, 0]
   vroom.program.uniformLoc('model').mat4f matrix.model
   update_normal_matrix()

rotateZ = (angle) ->
   mat4.rotate matrix.model, matrix.model, angle, [0, 0, 1]
   vroom.program.uniformLoc('model').mat4f matrix.model
   update_normal_matrix()

rotate = (angle, axis) ->
   mat4.rotate matrix.model, matrix.model, angle, axis
   vroom.program.uniformLoc('model').mat4f matrix.model
   update_normal_matrix()


scaleX = (sx) ->
   mat4.scale matrix.model, matrix.model, [sx, 1, 1]
   vroom.program.uniformLoc('model').mat4f matrix.model
   update_normal_matrix()

scaleY = (sy) ->
   mat4.scale matrix.model, matrix.model, [1, sy, 1]
   vroom.program.uniformLoc('model').mat4f matrix.model
   update_normal_matrix()

scaleZ = (sz) ->
   mat4.scale matrix.model, matrix.model, [1, 1, sz]
   vroom.program.uniformLoc('model').mat4f matrix.model
   update_normal_matrix()

scale =  ->
   args = arguments
   if args.length == 3
      mat4.scale matrix.model, matrix.model, vec3.fromValues(args[0], args[1], args[2])
   else
      mat4.scale matrix.model, matrix.model, vec3.fromValues(args[0], args[0], args[0])
   vroom.program.uniformLoc('model').mat4f matrix.model
   update_normal_matrix()


# Exports

window.translateX = translateX
window.translateY = translateY
window.translateZ = translateZ
window.translate = translate

window.rotateX = rotateX
window.rotateY = rotateY
window.rotateZ = rotateZ
window.rotate = rotate

window.scaleX = scaleX
window.scaleY = scaleY
window.scaleZ = scaleZ
window.scale = scale

