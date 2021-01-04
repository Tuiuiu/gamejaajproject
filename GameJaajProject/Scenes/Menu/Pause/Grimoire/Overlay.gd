extends TextureRect

onready var selection = preload("res://Scenes/Menu/Pause/Grimoire/SpellSelection.tscn")
onready var pause = get_parent()
var path = "res://Scenes/Menu/Pause/Grimoire/Pages/"
var scenes: Array = []
var current_path: String = ""
var grimoire_is_open = false
var page_number = 0

func _ready():
    Global.active_menu = "grimoire"
    add_child(selection.instance())
    
func _input(event):
    if grimoire_is_open and Global.active_menu == 'grimoire':
        if event.is_action_pressed("ui_cancel"):
            grimoire_is_open = false
            remove_child(get_child(0)) 
            add_child(selection.instance())
        if event.is_action_pressed("ui_right"):
            page_number += 1
        if event.is_action_pressed("ui_left"):
            page_number -= 1          
    elif !grimoire_is_open and Global.active_menu == 'grimoire':
        if event.is_action_pressed("ui_cancel"):
            remove_child(get_child(0))
            queue_free()
            pause.remove_grimoire() 

func _process(delta):
    if grimoire_is_open:
        var page = load(current_path + scenes[page_number % len(scenes)])
        remove_child(get_child(0))
        add_child(page.instance())
        
func get_scenes(spell: String) -> Array:
    var p = path + spell
    var scenes: Array = []
    var dir := Directory.new()
    if dir.open(p) == OK:
        dir.list_dir_begin()
        var file_name = dir.get_next()
        while file_name != "":
            if !dir.current_is_dir():
                scenes.append(file_name)
            file_name = dir.get_next()
    return scenes

func open_grimoire(spell):
    grimoire_is_open = true
    scenes = get_scenes(spell)
    current_path = path + spell
