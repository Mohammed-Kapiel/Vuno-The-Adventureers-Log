extends CanvasLayer

@onready var panel = $Panel
@onready var popup = $Popup
@onready var popup_label = $Popup/Popup_Label

func activate(is_active : bool):
	visible = is_active
