extends Objective

@export var mana_threshold = 800

func start():
	popup_label.text = "You need to get below " + str(mana_threshold) + " Mana!"
	popup.visible = true
	
	SpellManager.mana_changed.connect(mana_check)

func mana_check(new_value:float):
	if new_value <= mana_threshold:
		end()
