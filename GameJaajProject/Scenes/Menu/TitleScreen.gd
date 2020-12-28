extends Control

func start_game():
    get_tree().change_scene("res://Scenes/World/World.tscn")


func quit_game():
    get_tree().quit()
