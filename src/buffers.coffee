class ArrayBuffer
   constructor: () ->
      @gl = State.get().gl
      @_vao = @gl.ext.createVertexArrayOES()
      @bind()

   bind: ->
      @gl.ext.bindVertexArrayOES @_vao

   protect: ->
      @gl.ext.bindVertexArrayOES null


class Buffer
   constructor: (@_type, data, hint=State.get().gl.STATIC_DRAW) ->
      @gl = State.get().gl
      @_buffer = @gl.createBuffer()
      @_count = data.length
      @_byte_size = data.BYTES_PER_ELEMENT

      @bind()
      @loadData data, hint

   bind: ->
      @gl.bindBuffer @_type, @_buffer

   protect: ->
      @gl.bindBuffer @_type, null

   loadData: (data, hint) ->
      @gl.bufferData @_type, data, hint

   count: ->
      @_count

   offset: (n) ->
      n * @_byte_size

class VertexBuffer extends Buffer
   constructor: (data, hint=State.get().gl.STATIC_DRAW) ->
      super State.get().gl.ARRAY_BUFFER, data, hint

class IndexBuffer extends Buffer
   constructor: (data, hint=State.get().gl.STATIC_DRAW) ->
      super State.get().gl.ELEMENT_ARRAY_BUFFER, data, hint


window.ArrayBuffer = ArrayBuffer
window.Buffer = Buffer
window.VertexBuffer = VertexBuffer
window.IndexBuffer = IndexBuffer
