extends CanvasLayer

@onready var panel = $Panel
@onready var popup = $Popup
@onready var popup_label = $Popup/Popup_Label
@onready var win_menu = $"Win Menu"
@onready var v_box_container = $MarginContainer2/VBoxContainer2/VBoxContainer

func activate(is_active : bool):
	visible = is_active
	if is_active:
		for child in v_box_container.get_children():
			(child as Spell_Button).get_data()
