class_name BaseCustomButton extends Button

@onready var audio_stream_player = AudioPlayer


func _on_pressed():
	audio_stream_player.play_sfx()
