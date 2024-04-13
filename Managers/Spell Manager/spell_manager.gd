class_name Spell_Manager extends Node

signal mana_changed(mana:float)

@export var mana : float = 999:
	set(new_value):
		mana = new_value
		mana_changed.emit(mana)
