extends Node2D


var current_scene = "cabin"
var change_scene = false

func _ready():
	if Global.last_cabin_position != Vector2(0, 0):
		$TileMap/player.position = Global.last_cabin_position + Vector2(0, 5)

func _on_to_n_1_body_entered(body):
	if body.is_in_group("Player"):
		Global.last_cabin_position = $TileMap/player.position
		change_scene = true
		change_scenes()

func change_scenes():
	if change_scene == true:
		if current_scene == "cabin":
			get_tree().change_scene_to_file("res://N1.tscn")
