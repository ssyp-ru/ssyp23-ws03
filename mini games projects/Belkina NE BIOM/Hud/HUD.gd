extends Node2D

func _ready():
	$Label.text = "0"

func _process(delta):
	$Label.text = str(config.score)
	config.l = self

func zerow():
	$Label.text = 0
