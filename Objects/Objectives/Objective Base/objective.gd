class_name Objective extends Node

@onready var popup = Hud.popup
@onready var popup_label = Hud.popup_label

signal ended

func start():
	pass

func _process(delta):
	if process_check(delta):
		end()

func process_check(delta) -> bool:
	return false

func end():
	ended.emit()
