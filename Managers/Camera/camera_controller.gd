class_name  CameraController 
extends CharacterBody2D

@onready var main_camera : Camera2D = $"Main Camera"
@export var speed = 300
@export var zoom_speed: float = 5
var zoom_dir: float
@export var moveable_bounds : Rect2

@export var is_in_focus = false

func _input(event):
	if(event.is_action("zoom_camera_in")):
		zoom_dir = 1
	elif(event.is_action("zoom_camera_out")):
		zoom_dir = -1
	else:
		zoom_dir = 0

func get_input():
	var input_dir = Input.get_vector("move_camera_left", "move_camera_right", "move_camera_up", "move_camera_down")
	velocity = input_dir * speed

func _physics_process(delta):
	if (!is_in_focus):
		return
	
	get_input()
	var zoom_amount: float = zoom_dir * zoom_speed * delta
	main_camera.zoom += Vector2(zoom_amount, zoom_amount)
	zoom_dir = 0
	move_and_collide(velocity * delta)
