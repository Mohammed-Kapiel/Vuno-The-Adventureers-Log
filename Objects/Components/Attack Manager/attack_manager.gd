class_name Attack_Manager extends Area2D

var faction = Unit_Manager.factions.Player 
@onready var attack_timer = $"Attack Timer"
@onready var attack_collision_shape = $"Attack Collision Shape"
@onready var attack_timer_ui = $"Attack Timer UI"

var timer_wait_time = 1

var damage : float
@export var ignored : Array[Health_Manager]
var targets_in_range : Array[Health_Manager]

var show_attack_timer : bool = false:
	set(new_value):
		show_attack_timer = new_value
		attack_timer_ui.visible = new_value
		attack_timer_ui.visible = false

func setup_stats(new_faction, stats:Unit_Stats):
	if !stats:
		return
	faction = new_faction
	damage = stats.damage
	
	attack_collision_shape.shape = CircleShape2D.new()
	attack_collision_shape.shape.radius = stats.attack_range
	
	timer_wait_time = 1/stats.attack_speed
	attack_timer.wait_time = timer_wait_time
	attack_timer_ui.scale = stats.scale

func _process(delta):
	if show_attack_timer:
		if attack_timer.is_stopped():
			attack_timer_ui.visible = false
		else:
			attack_timer_ui.visible = true
			attack_timer_ui.value = 1 - (attack_timer.time_left / timer_wait_time)

func _on_area_entered(area):
	if area is Health_Manager:
		var tmp = area as Health_Manager
		if tmp.faction != faction and !ignored.has(tmp) and !targets_in_range.has(tmp):
			targets_in_range.append(tmp)
			tmp.death.connect(_on_area_exited)
			attack_timer.start()

func _on_area_exited(area):
	targets_in_range.erase(area)
	#area.death.disconnect(_on_area_exited)
	if targets_in_range.size() == 0:
		attack_timer.stop()

func _on_attack_timer_timeout():
	targets_in_range[0].recieve_damage(damage)
