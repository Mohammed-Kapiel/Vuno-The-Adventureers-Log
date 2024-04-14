extends Node

@export var menu_scene:String
var menu_instance

func _on_open_menu_requested():
	if menu_scene:
		menu_instance = load(menu_scene).instantiate()
		get_tree().get_root().get_child(1).add_child(menu_instance)

func _on_swap_scene_requested():
		var loading_screen_instance = preload("res://Managers/Scene Manager/loading_screen.tscn").instantiate()
		loading_screen_instance.target_scene_path = menu_scene
		get_tree().get_root().get_child(1).add_child(loading_screen_instance)
