class_name  CameraController 
extends CharacterBody2D

@onready var main_camera : Camera2D = $"Main Camera"

@export var selection_area_rect : Control
@export var selection_dead_zone : float

@export var speed = 300
@export var zoom_speed: float = 5
var zoom_dir: float

@export var moveable_bounds : Rect2
@export var is_in_focus = true

var mouse_pos = Vector2()
var mouse_pos_global = Vector2()

var mouse_start = Vector2()
var mouse_start_vector = Vector2()
var mouse_end = Vector2()
var mouse_end_vector = Vector2()

var is_dragging : bool = false

signal start_move_selection
signal area_selected

func _ready():
	draw_area(false)

func _input(event):
	if(event.is_action("zoom_camera_in")):
		zoom_dir = 1
	elif(event.is_action("zoom_camera_out")):
		zoom_dir = -1
	else:
		zoom_dir = 0
	
	if event is InputEventMouse:
		mouse_pos = event.position
		mouse_pos_global = get_global_mouse_position()

func get_input(delta):
	get_movement_input()
	get_slection_input()
	get_zoom_input(delta)

func get_movement_input():
	var input_dir = Input.get_vector("move_camera_left", "move_camera_right", "move_camera_up", "move_camera_down")
	velocity = input_dir * speed

func get_slection_input():
	if Input.is_action_just_pressed("select"):

			mouse_start = mouse_pos_global
			mouse_start_vector = mouse_pos
			is_dragging = true
	
	if Input.is_action_just_released("select"):
		if mouse_start_vector.distance_to(mouse_pos) > selection_dead_zone:
			mouse_end = mouse_pos_global
			mouse_end_vector = mouse_pos
			is_dragging = false 
			draw_area(false)
			emit_signal("area_selected")
		else:
			mouse_end = mouse_start
			is_dragging = false 
			draw_area(false)

	if is_dragging:
		mouse_end = mouse_pos_global
		mouse_end_vector = mouse_pos
		draw_area(true)

func get_zoom_input(delta):
	var zoom_amount: float = zoom_dir * zoom_speed * delta
	main_camera.zoom += Vector2(zoom_amount, zoom_amount)
	zoom_dir = 0

func _physics_process(delta):
	if (!is_in_focus):
		return
	
	get_input(delta)
	
	move_and_collide(velocity * delta)

func draw_area(is_drawn:bool):
	if is_drawn:
		selection_area_rect.size = abs(mouse_start_vector - mouse_end_vector)
		var pos = Vector2()
		pos.x = min(mouse_start_vector.x, mouse_end_vector.x)
		pos.y = min(mouse_start_vector.y, mouse_end_vector.y)
		selection_area_rect.position = pos
	else:
		selection_area_rect.size = Vector2(0, 0)


	
	
