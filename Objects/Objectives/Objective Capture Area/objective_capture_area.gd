extends Objective

@onready var collision_shape_2d = $"Objective Area/CollisionShape2D"
@onready var timer : Timer = $Timer

@export_multiline var objective_text = "Capture the Cemetary!"

var is_checking = false
var units_in_area : Array[Unit]

func start():
	popup_label.text = objective_text
	popup.visible = true
	
	visible = true
	

func process_check(_delta) -> bool:
	var is_captured = true
	for unit in units_in_area:
		if unit and unit.faction != Unit_Manager.factions.Player:
			is_captured = false
			break
	if units_in_area.size() > 0 and is_captured:
		if timer.is_stopped():
			timer.start()
			is_checking = true
	elif is_checking:
		timer.stop()
	return false

func remove_from_list(unit:Unit):
	units_in_area.erase(unit)

func _on_timer_timeout():
	end()

func _on_area_2d_body_entered(body):
		if body is Unit:
			units_in_area.append(body)
			body.health_manager.death.connect(_unit_dead)

func _unit_dead(dead_health_manager):
	if dead_health_manager is Health_Manager:
		remove_from_list(dead_health_manager.get_parent())

func _on_area_2d_body_exited(body):
	remove_from_list(body)

func _draw():
	# Calculate the arc parameters.
	var center : Vector2 = collision_shape_2d.position
	var radius : float = collision_shape_2d.shape.radius
	var start_angle : float = 0
	var end_angle : float = 360
	# Finally, draw the arc.
	draw_arc(center, radius, start_angle, end_angle, 100, collision_shape_2d.debug_color,10)
