extends StaticBody2D

@export  var spikes_showed: bool = false
@export  var timer_enabled: bool = false


var spikes_showed_previous: bool = false
var timer_enabled_previous: bool = false

var voices = DisplayServer.tts_get_voices_for_language("ru")
var voice_id = voices[0]

func _process(_delta: float) -> void:
	if self.timer_enabled and $Area2D/Timer.is_stopped():
		$Area2D/Timer.start() # Если self.timer_enabled == true и $Timer остановлен - запустить таймер

func _on_Timer_timeout() -> void:
	if self.timer_enabled: # Если timer_enabled == true -- переключить состояние шипов.
		self.spikes_showed = !self.spikes_showed
		$Area2D/Timer.start()


func _on_area_2d_body_entered(body: Node) -> void:
	if body.name == "player":
		get_tree().change_scene_to_file("res://Loss/loss_1.tscn")
		DisplayServer.tts_speak("Вы проиграли", voice_id)
