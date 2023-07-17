extends Node2D
@export var next_scene = "res://Level_5/level_5.tscn"
var voices = DisplayServer.tts_get_voices_for_language("ru")
var voice_id = voices[0]



func _on_body_entered(body):
	if body.name == "player":	
		config.score +=1
		get_tree().change_scene_to_file(next_scene)
		DisplayServer.tts_speak("Пятый уровень", voice_id)
