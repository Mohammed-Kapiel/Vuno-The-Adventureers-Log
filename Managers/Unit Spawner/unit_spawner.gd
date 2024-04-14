class_name Unit_Spawner extends Node2D

@onready var levels : Array[Node] = get_tree().get_nodes_in_group("Levels")
@onready var spawn_timer = $"Spawn Timer"

const UNIT = preload("res://Objects/Units/unit.tscn")

var is_spawning : bool = false

@export var unit_stats : Unit_Stats

func prepare_spawn(stats : Unit_Stats):
	unit_stats = stats
	preview_spawn()
	
	spawn_timer.start()

func spawn_ready():
	is_spawning = true

func preview_spawn():
	pass
	
func _spawn():

	var unit = UNIT.instantiate()
	
	levels[0].add_child(unit)
	
	unit.stats = unit_stats
	
	unit.position = get_global_mouse_position()

func _physics_process(delta):
	if !is_spawning:
		return
	
	if Input.is_action_just_released("select"):
		_spawn()
	
	if Input.is_action_just_released("move"):		
		is_spawning = false
