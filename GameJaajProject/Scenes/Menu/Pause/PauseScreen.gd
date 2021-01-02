extends Control

onready var grimoire_resource = preload("res://Scenes/Menu/Pause/Grimoire/Grimoire.tscn")

func _ready():
    visible = false

func _on_ContinueButton_pressed():
    get_tree().paused = false
    visible = false

func _on_QuitButton_pressed():
    Global.goto_scene("res://Scenes/Menu/Title/TitleScreen.tscn")

func _on_GrimoireButton_pressed():
    var grimoire = grimoire_resource.instance()
    add_child(grimoire)
    $AnimatedSprite.play("open")
