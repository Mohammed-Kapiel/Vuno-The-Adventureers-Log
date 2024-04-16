class_name Unit extends CharacterBody2D

@export var faction = unit_manager.factions.Player
@export var stats : Unit_Stats:
	set(new_val):
		stats = new_val
		update_stats()

@export var is_selected = false
@onready var selection_overlay = $"Selection Overlay"
@onready var attack_range_draw = $"Attack Range Draw"

@onready var navigation_agent : NavigationAgent2D= $NavigationAgent2D

@onready var unit_manager : Unit_Manager = UnitManager
@onready var attack_manager : Attack_Manager = $"Attack Manager"
@onready var health_manager : Health_Manager = $"Health Manager"
@onready var art : Sprite2D = $Art
@onready var collision_shape_2d = $CollisionShape2D

@onready var attack_ui_container = $"Attack UI Container"
@onready var health_ui_container = $"Health UI Container"


@onready var detection_collision_shape = $"Detection Range/Detection Collision Shape"

var is_following : bool = false
@export var move_target : Vector2

func _ready():
	setup()

func setup():
	update_stats()
	
func update_stats():
	if !stats :
		return 
	
	attack_range_draw.color = collision_shape_2d.debug_color
	attack_range_draw.attack_range = stats.attack_range
	
	health_manager.scale = stats.scale
	art.scale = stats.scale
	selection_overlay.scale = stats.scale
	collision_shape_2d.scale = stats.scale
	attack_ui_container.scale = stats.scale
	health_ui_container.scale = stats.scale
	
	art.texture = stats.texture
	attack_manager.setup_stats(faction, stats)
	health_manager.setup_stats(faction, stats)
	
	if detection_collision_shape : 
		detection_collision_shape.shape = CircleShape2D.new()
		detection_collision_shape.shape.radius = stats.detection_range
	
	unit_manager.add_unit(self, faction)

func select(is_true:bool = true):
	is_selected = is_true

	selection_overlay.visible = is_selected
	attack_range_draw.visible = is_selected
	attack_manager.show_attack_timer = is_selected

func _input(event):
		if event.is_action("move"):
			if is_selected:
				move_target = get_global_mouse_position()
				navigation_agent.target_position = move_target

func _physics_process(delta):

		is_following = navigation_agent.is_target_reached()
		if !is_following:
			var direction : Vector2 = navigation_agent.get_next_path_position() - global_position
			direction = direction.normalized()
			velocity = velocity.lerp(direction * stats.move_speed, stats.move_acceleration * delta)
			move_and_slide()

func on_death(_health_manager_passthrough):
	queue_free()


