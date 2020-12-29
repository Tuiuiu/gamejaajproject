extends Control

func start_game():
    Global.goto_scene("res://Scenes/World/World.tscn")

func quit_game():
    get_tree().quit()
