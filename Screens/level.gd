extends Node

@export var hud_is_active : bool = false

func _ready():
	Hud.activate(hud_is_active)
	UnitManager.activate(hud_is_active)
	SpellManager.activate(hud_is_active)
