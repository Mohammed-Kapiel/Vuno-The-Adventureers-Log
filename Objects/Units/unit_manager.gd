class_name Unit_Manager extends Node

var units : Array[Unit]
var selected_units : Array[Unit]

#func _ready():
	#var tmp = get_tree().get_nodes_in_group("Units")
	#for t in tmp:
		#var unit : Unit = t as Unit
		#units.append(unit)
		#unit.tree_exiting.connect(func(): remove_unit(unit))
		#

func add_unit(unit_to_add: Unit):
	units.append(unit_to_add)
	unit_to_add.tree_exiting.connect(func(): remove_unit(unit_to_add))

func on_area_selected(camera_controller: CameraController):
	var area = []
	area.append( Vector2( min(camera_controller.mouse_start.x, camera_controller.mouse_end.x), min(camera_controller.mouse_start.y, camera_controller.mouse_end.y)))
	area.append( Vector2( max(camera_controller.mouse_start.x, camera_controller.mouse_end.x), max(camera_controller.mouse_start.y, camera_controller.mouse_end.y))) 
	_get_units_in_area(area)
	
func _get_units_in_area(area):

	selected_units.clear()
	
	for unit in units:
		if (unit.position.x > area[0].x) and (unit.position.x < area[1].x):
			if (unit.position.y > area[0].y) and (unit.position.y < area[1].y):
				selected_units.append(unit)
				unit.select()
			else:
				unit.select(false)
		else:
			unit.select(false)

func remove_unit(unit_to_remove: Unit):
	units.erase(unit_to_remove)
