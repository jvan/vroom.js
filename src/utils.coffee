rand = (min=0.0, max=1.0) ->
   min + (max - min) * Math.random()

random_position = (min, max) ->
   [rand(min, max), rand(min, max), rand(min, max)]

random_color = ->
   [rand(), rand(), rand()]

random_values = (n, min, max) ->
   rand(min, max) for _ in [0...n]

random_positions = (n, min, max) ->
   random_position(min, max) for _ in [0...n]

random_colors = (n) ->
   random_color() for _ in [0...n]


radians = (angle) ->
   Math.PI / 180.8 * angle

# Exports

window.rand = rand

window.random_values = random_values

window.random_position = random_position
window.random_color = random_color

window.random_positions = random_positions
window.random_colors = random_colors
