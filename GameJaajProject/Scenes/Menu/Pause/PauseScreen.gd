extends Control

onready var grimoire_resource = preload("res://Scenes/Menu/Pause/Grimoire/Grimoire.tscn")
onready var grimoire_pages: Array

func _ready():
    visible = false
    load_grimoire_pages()
    
func load_grimoire_pages():
    var dir = Directory.new()
    var path = "res://Scenes/Menu/Pause/Grimoire/Pages/Fireballs"
    if dir.open(path) == OK:
        dir.list_dir_begin()
        var filename = dir.get_next()
        while filename != "":
            pass

func _on_ContinueButton_pressed():
    get_tree().paused = false
    visible = false

func _on_QuitButton_pressed():
    Global.goto_scene("res://Scenes/Menu/Title/TitleScreen.tscn")

func _on_GrimoireButton_pressed():
    var grimoire = grimoire_resource.instance()
    add_child(grimoire)
    $AnimatedSprite.play("open")
    # open grimoire logic here
    #$AnimatedSprite.play("close")
    #remove_child(grimoire)
