class_name Unit extends CharacterBody2D

@export var faction = unit_manager.factions.Player
@export var stats : Unit_Stats:
	set(new_val):
		stats = new_val
		update_stats()

@export var is_selected = false
@onready var selection_overlay = $"Selection Overlay"
@onready var navigation_agent = $NavigationAgent2D

@onready var unit_manager : Unit_Manager = UnitManager
@onready var attack_manager : Attack_Manager = $"Attack Manager"
@onready var health_manager : Health_Manager = $"Health Manager"

@onready var detection_collision_shape = $"Detection Range/Detection Collision Shape"

var is_following : bool = false
@export var move_target : Vector2

func _ready():
	
	unit_manager.add_unit(self, faction)
	update_stats()

func update_stats():
	if attack_manager : attack_manager.setup_stats(faction, stats)
	if health_manager : health_manager.setup_stats(faction, stats)
	
	if detection_collision_shape : detection_collision_shape.shape = CircleShape2D.new()
	if detection_collision_shape : detection_collision_shape.shape.radius = stats.detection_range

func select(is_true:bool = true):
	is_selected = is_true
	selection_overlay.visible = is_selected

func _input(event):
		if event.is_action("move"):
			if is_selected:
				move_target = get_global_mouse_position()
				navigation_agent.target_position = move_target

func _physics_process(delta):
		var direction : Vector2 = navigation_agent.get_next_path_position() - global_position
		direction = direction.normalized()
		is_following = navigation_agent.is_target_reached()
		if !is_following:
			velocity = velocity.lerp(direction * stats.move_speed, stats.move_acceleration * delta)
			move_and_slide()

func on_death(health_manager):
	queue_free()

func _on_detection_range_body_entered(body):
	print(self.name + " detected " + body.name + " entered")


func _on_detection_range_body_exited(body):
	print(self.name + " detected " + body.name + " exited")
