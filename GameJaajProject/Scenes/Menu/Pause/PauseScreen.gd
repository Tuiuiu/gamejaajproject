extends Control

func _ready():
    visible = false

func _on_ContinueButton_pressed():
    get_tree().paused = false
    visible = false
    
func _on_QuitButton_pressed():
    get_tree().change_scene("res://Scenes/Menu/Title/TitleScreen.tscn")

