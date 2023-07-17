extends Node2D

var pause
var zoom = 1

func sleep(seconds):
	await get_tree().create_timer(seconds).timeout
