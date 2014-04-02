init_context = (id) ->
   canvas = $(id)[0]
   gl =  canvas.getContext 'experimental-webgl'
   gl.ext = gl.getExtension "OES_vertex_array_object"
   gl.canvas = canvas
   gl

window.init_context = init_context
