class_name Unit_Spawner extends Node2D

@onready var level : Node = get_tree().get_first_node_in_group("Levels")
@onready var unit_manager : Unit_Manager = UnitManager
@onready var spawn_collision_shape = $"Spawn Area/Spawn Collision Shape"
var spawn_radius = 0


@onready var spawn_timer = $"Spawn Timer"

const UNIT = preload("res://Objects/Units/unit.tscn")

@export var is_automatic : bool = false
@export var spawn_rate : float = 0.25

var spawned : int = 0
@export var max_spawned : int = 5

var is_spawning : bool = false

@export var faction = 1
@export var unit_stats : Unit_Stats

func _ready():
	unit_manager.add_spawner(self, faction)
	spawn_radius = spawn_collision_shape.shape.radius
	
	if is_automatic:
		spawn_timer.one_shot = false
		spawn_timer.wait_time = 1/spawn_rate
		spawn_timer.start()

func prepare_spawn(stats : Unit_Stats):
	unit_stats = stats
	preview_spawn()
	
	spawn_timer.start()

func spawn_ready():
	is_spawning = true
	
	if is_automatic:
		_spawn(position)

func preview_spawn():
	pass
	
func _spawn(spawn_position : Vector2):
	spawned += 1
	if is_automatic and spawned > max_spawned:
		return
	var unit = UNIT.instantiate()
	level.add_child(unit)
	unit.faction = faction
	unit.stats = unit_stats
	var rand_offset_x = randi_range(-spawn_radius, spawn_radius)
	var rand_offset_y = randi_range(-spawn_radius, spawn_radius)
	unit.position = spawn_position + Vector2(rand_offset_x, rand_offset_y)


func _physics_process(_delta):
	if is_automatic or !is_spawning:
		return
	
	if Input.is_action_just_released("select"):
		_spawn(get_global_mouse_position())
	
	if Input.is_action_just_released("move"):		
		is_spawning = false
