class_name Attack_Manager extends Area2D

@onready var attack_timer = $"Attack Timer"
@onready var attack_collision_shape = $"Attack Collision Shape"

var damage : float

@export var ignored : Array[Health_Manager]
var targets_in_range : Array[Health_Manager]

func setup_stats(stats:Unit_Stats):
	damage = stats.damage
	
	attack_collision_shape.shape = CircleShape2D.new()
	attack_collision_shape.shape.radius = stats.attack_range
	
	attack_timer.wait_time = 1/stats.attack_speed

func _on_area_entered(area):
	if area is Health_Manager:
		var tmp = area as Health_Manager
		if !ignored.has(tmp):
			targets_in_range.append(tmp)
			tmp.death.connect(_on_area_exited)
			attack_timer.start()

func _on_area_exited(area):
	targets_in_range.erase(area)
	area.death.disconnect(_on_area_exited)
	if targets_in_range.size() == 0:
		attack_timer.stop()

func _on_attack_timer_timeout():
	targets_in_range[0].recieve_damage(damage)
