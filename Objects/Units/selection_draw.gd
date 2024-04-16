extends Node2D

var color
var attack_range

func _draw():
	# Calculate the arc parameters.
	var center : Vector2 = Vector2(0,0)
	var radius : float = attack_range
	var start_angle : float = 0
	var end_angle : float = 360
	# Finally, draw the arc.
	draw_arc(center, radius, start_angle, end_angle, 100, color,4)
