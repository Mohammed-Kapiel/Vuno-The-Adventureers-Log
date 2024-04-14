extends Button

@onready var unit_spawner : Unit_Spawner = UnitSpawner

@export var spell_stats : Spell

func _ready():
	if spell_stats : text = spell_stats.name

func _on_pressed():
	SpellManager.mana -= spell_stats.mana_cost
	
	if spell_stats and spell_stats.is_unit_spawn and spell_stats.unit_stat:
		unit_spawner.prepare_spawn(spell_stats.unit_stat)
