class_name Unit_Stats extends Resource

@export var texture : Texture2D

@export var mana_cost : float = 10

@export var move_acceleration : float = 50
@export var move_speed : float = 200

@export var max_health : float = 100

@export var damage : float = 10
@export var attack_speed : float = 0.5
@export var attack_range : float = 50

@export var detection_range : float = 200

func _to_string():
	var tmp_str = ""
	tmp_str += "Mana: " + str(mana_cost)
	tmp_str += "\nSpeed: " + str(move_speed)
	tmp_str += "\nHealth: " + str(max_health)
	tmp_str += "\nDamage: " + str(damage)
	tmp_str += "\nAttack Rate /s: " + str(1/attack_speed)
	tmp_str += "\nAttack Range: " + str(attack_range)
	return tmp_str
