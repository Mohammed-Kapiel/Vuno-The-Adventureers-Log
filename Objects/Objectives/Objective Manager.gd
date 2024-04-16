class_name Objective_Manager extends Node

var level_objectives : Array[Node]

signal win_game


func _ready():
	level_objectives = get_children()
	start_objective(level_objectives.front() as Objective)
	
func start_objective(objective : Objective):
	objective.start()
	objective.ended.connect(end_objective)

func end_objective():
	
	var tmp = level_objectives.front()
	level_objectives.pop_front()
	tmp.queue_free()
	
	if level_objectives.size() == 0:
		win_game.emit()
		Hud.win_menu.visible = true
	else:
		start_objective(level_objectives.front() as Objective)
