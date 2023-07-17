extends Node2D

var ding = 0

func _ready():
	pass

func _process(delta):
	if not $FrogsSFX.playing:
		$FrogsSFX.play()


#func _on_button_pressed():
	#$FrogsSFX.play()
	#pass # Replace with function body.


func _on_button_2_pressed():
	if ding == 0:
		$DingSFX.play()
	
var voices = DisplayServer.tts_get_voices_for_language("ru")
var voice_id = voices[0]


func _on_button_3_pressed():
	DisplayServer.tts_speak("Пожалуйста, не нажимайте эту кнопку!", voice_id)
