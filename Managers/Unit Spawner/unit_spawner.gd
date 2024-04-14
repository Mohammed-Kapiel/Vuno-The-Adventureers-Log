class_name Unit_Spawner extends Node2D

@onready var level : Node = get_tree().get_first_node_in_group("Levels")
@onready var unit_manager : Unit_Manager = UnitManager

@onready var spawn_timer = $"Spawn Timer"

const UNIT = preload("res://Objects/Units/unit.tscn")

var is_spawning : bool = false

@export var faction = unit_manager.factions.Player
@export var unit_stats : Unit_Stats

func _ready():
	unit_manager.add_spawner(self, faction)

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
	
	level.add_child(unit)
	
	unit.stats = unit_stats
	
	unit.position = get_global_mouse_position()

func _physics_process(delta):
	if !is_spawning:
		return
	
	if Input.is_action_just_released("select"):
		_spawn()
	
	if Input.is_action_just_released("move"):		
		is_spawning = false
