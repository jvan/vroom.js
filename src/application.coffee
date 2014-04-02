class VroomApp
   @program: undefined

   constructor: (id, @args=null) ->
      console.log '[VroomApp.constructor]'
      State.get().gl = init_context id
      #gl = @gl
      @gl = State.get().gl

      @callbacks =
         init: undefined
         display: undefined
         frame: undefined
         button_press: undefined
         button_release: undefined

      @program = new Program '/shaders/default.vert', '/shaders/default.frag'
      @program.use()

      @eye =
         x: 0.0
         y: 0.0
         z: 5.0

      mat4.lookAt matrix.view,
         vec3.fromValues(@eye.x, @eye.y, @eye.z),
         vec3.fromValues(0, 0, 0),
         vec3.fromValues(0, 1, 0)

      aspect = @gl.canvas.width / @gl.canvas.height
      mat4.perspective matrix.proj, 45, aspect, 1, 100

      @program.uniformLoc('view').mat4f matrix.view
      @program.uniformLoc('proj').mat4f matrix.proj

      mat4.transpose matrix.norm, matrix.norm
      @program.uniformLoc('normalMatrix').mat4f matrix.norm

      light_dir = new vec3.fromValues 0.5, 3.0, 4.0
      vec3.normalize light_dir, light_dir

      @program.uniformLoc('light.direction').vec3f light_dir

      @program.uniformLoc('light.color').vec3f [1.0, 1.0, 1.0]
      @program.uniformLoc('light.ambient').vec3f [0.3, 0.3, 0.3]

      vroom.set_program @program

      lighting false

      @gl.enable @gl.DEPTH_TEST
      background 0, 0, 0, 1

      @_init_event_handlers()

   _init_event_handlers: ->
      @dragging = false
      @prev = undefined
      @current_angle = [0.0, 0.0]

      @gl.canvas.onmousedown = (ev) =>
         click = x: ev.clientX, y: ev.clientY
         rect = ev.target.getBoundingClientRect()

         if rect.left <= click.x and click.x < rect.right and
            rect.top  <= click.y and click.y < rect.bottom
               @prev = click
               @dragging = true
         else
            @dragging = false

         if @callbacks.button_press
            @callbacks.button_press click

      @gl.canvas.onmouseup = (ev) =>
         #console.log '[VroomApp.onmouseup]'
         @dragging = false

         click = x: ev.clientX, y: ev.clientY

         if @callbacks.button_release
            @callbacks.button_release click

      @gl.canvas.onmousemove = (ev) =>
         #console.log '[VroomApp.onmousemove]'
         click = x: ev.clientX, y: ev.clientY

         if @dragging
            factor = 100/@gl.canvas.height
            dx = factor * (click.x - @prev.x)
            dy = factor * (click.y - @prev.y)

            @current_angle[0] = Math.max Math.min(@current_angle[0] + dy, 90.0), -90.0
            @current_angle[1] = @current_angle[1] + dx

            State.get().current_angle = @current_angle

         @prev = click

      @gl.canvas.onwheel = (ev) =>
         if ev.deltaY < 0
            @eye.z += 0.25
         else
            @eye.z -= 0.25
         
      window.onkeydown = (ev) =>
         console.log '[VroomApp.onkeydown]: ev.key=' + ev.keyCode

      window.onkeyup = (ev) =>
         console.log '[VroomApp.onkeyup]: ev.key=' + ev.keyCode

   reload: ->
      console.log '[VroomApp.reload]'

      @callbacks.init    = window.init
      @callbacks.display = window.display
      @callbacks.frame   = window.frame
      @callbacks.button_press = window.button_press
      @callbacks.button_release = window.button_release

      if not @callbacks.init.hasOwnProperty 'no_update' or @callbacks.init.no_update == false
         @callbacks.init @args if @callbacks.init
      @callbacks.frame() if @callbacks.frame

      @display()

   display: ->
      @gl.clear @gl.COLOR_BUFFER_BIT | @gl.DEPTH_BUFFER_BIT

      #@program.use()
      vroom.program.use()

      mat4.lookAt matrix.view,
         vec3.fromValues(@eye.x, @eye.y, @eye.z),
         vec3.fromValues(0, 0, 0),
         vec3.fromValues(0, 1, 0)

      @program.uniformLoc('view').mat4f matrix.view

      #matrix.model = mat4.create()
      mat4.identity matrix.model

      mat4.rotateX matrix.model, matrix.model, radians(@current_angle[0])
      mat4.rotateY matrix.model, matrix.model, radians(@current_angle[1])

      #console.log '  [current_angle]: ' + @current_angle

      @program.uniformLoc('model').mat4f matrix.model

      if @callbacks.display
         @callbacks.display()

      #@program.protect()

   frame: =>

      if @callbacks.frame
         @callbacks.frame()

      @display()

      requestAnimationFrame @frame

   run: ->
      console.log '[VroomApp.run]'
      @frame()


# Exports

window.VroomApp = VroomApp
