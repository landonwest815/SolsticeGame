extends Node2D

var current_scene = "N1"
var change_scene = false

func _ready():
	if Global.last_N1_position != Vector2(0, 0):
		$TileMap/player.position = Global.last_N1_position + Vector2(0, -5)

func _on_to_cabin_body_entered(body):
	if body.is_in_group("Player"):
		Global.last_N1_position = $TileMap/player.position
		change_scene = true
		change_scenes()

func change_scenes():
	if change_scene == true:
		if current_scene == "N1":
			get_tree().change_scene_to_file("res://CabinArea.tscn")
