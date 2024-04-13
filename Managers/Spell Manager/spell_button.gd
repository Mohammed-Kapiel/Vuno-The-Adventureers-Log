extends Button

@export var spell_stats : Spell

func _on_pressed():
	SpellManager.mana -= spell_stats.mana_cost
