extends Button

@onready var unit_manager : Unit_Manager = UnitManager

var unit_spawner : Unit_Spawner
@export var spell_stats : Spell

func _ready():
	unit_spawner = unit_manager.spawners[unit_manager.factions.Player].front()
	
	if spell_stats : text = spell_stats.name

func _on_pressed():
	SpellManager.mana -= spell_stats.mana_cost
	
	if spell_stats and spell_stats.is_unit_spawn and spell_stats.unit_stat:
		if !unit_spawner:
			unit_spawner = unit_manager.spawners[unit_manager.factions.Player].front()
		
		unit_spawner.prepare_spawn(spell_stats.unit_stat)
		
