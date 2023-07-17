extends Node2D
var voices = DisplayServer.tts_get_voices_for_language("ru")
var voice_id = voices[0]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not $AudioStreamPlayer2D.playing: 
		$AudioStreamPlayer2D.play()
	pass


func _on_button_3_pressed():
	DisplayServer.tts_speak("Первый уровень", voice_id)
	get_tree().change_scene_to_file("res://Level_1/game.tscn")
	

