extends Label

func _ready():
	SpellManager.mana_changed.connect(update_label)
	update_label(SpellManager.mana)

func update_label(data):
	text = str(data)
