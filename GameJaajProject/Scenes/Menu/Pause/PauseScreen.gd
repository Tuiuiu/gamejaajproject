extends Control

onready var grimoire_resource = preload("res://Scenes/Menu/Pause/Grimoire/Grimoire.tscn")
onready var grimoire_overlay = preload("res://Scenes/Menu/Pause/Grimoire/Overlay.tscn")
onready var grimoire_pages: Array

func _ready():
    visible = false

func _on_ContinueButton_pressed():
    get_tree().paused = false
    visible = false

func _on_QuitButton_pressed():
    Global.goto_scene("res://Scenes/Menu/Title/TitleScreen.tscn")

func _on_GrimoireButton_pressed():
    Global.active_menu = "grimoire"
    var grimoire = grimoire_resource.instance()
    add_child(grimoire)
    $Grimoire.play("open")
    yield($Grimoire, "animation_finished")
    # opens a overlay scene and every page is loaded as an child to the overlay node
    var overlay = grimoire_overlay.instance()
    add_child(overlay)

func remove_grimoire():
    $Grimoire.play("close")
    yield($Grimoire, "animation_finished")
    remove_child($Grimoire)
    Global.active_menu = "pause"
