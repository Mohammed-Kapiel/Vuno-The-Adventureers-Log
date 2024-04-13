class_name Unit extends CharacterBody2D

@export var is_selected = false
@onready var selection_overlay = $"Selection Overlay"

func select(is_true:bool = true):
	is_selected = is_true
	selection_overlay.visible = is_selected
