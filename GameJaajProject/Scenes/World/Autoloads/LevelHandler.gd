extends Node

var last_HP = 100.0
var last_max_hp = 100.0
var currentLevel = 0
var currentSpells = 0
var levels = [
    [1.0, 3, 4.0, 0],
    [1.0, 2, 3.0, 0],
    [0.5, 0, 0.5, 1, 0.5, 0, 0.5, 1, 0.5, 0],
    [2.0, 0, 2.0, 1, 2.0, 0]
]

var skillSets = [
    {
    0: [KEY_R, KEY_F, KEY_B],
    3: [KEY_F, KEY_L],
    },
    {
    0: [KEY_R, KEY_F, KEY_B],
    1: [KEY_B, KEY_F, KEY_B],
    2: [KEY_G, KEY_F, KEY_B],
    3: [KEY_F, KEY_L]
    },
    {
    0: [KEY_R, KEY_F, KEY_B],
    1: [KEY_B, KEY_F, KEY_B],
    2: [KEY_G, KEY_F, KEY_B],
    3: [KEY_F, KEY_L],
    4: [KEY_R, KEY_H, KEY_E, KEY_X],
    5: [KEY_B, KEY_H, KEY_E, KEY_X],
    6: [KEY_G, KEY_H, KEY_E, KEY_X]
    },
    {
    0: [KEY_R, KEY_F, KEY_B],
    1: [KEY_B, KEY_F, KEY_B],
    2: [KEY_G, KEY_F, KEY_B],
    3: [KEY_F, KEY_L],
    4: [KEY_R, KEY_H, KEY_E, KEY_X],
    5: [KEY_B, KEY_H, KEY_E, KEY_X],
    6: [KEY_G, KEY_H, KEY_E, KEY_X],
    7: [KEY_H, KEY_E, KEY_A, KEY_L],
    8: [KEY_T, KEY_O, KEY_L, KEY_L]
    }
]

func _ready():
    pass # Replace with function body.

func get_level(level):
    return levels[level]
    
func get_spells():
    return skillSets[currentLevel]

func get_current_level():
    return levels[currentLevel]    

func next_level():
    currentLevel = ((currentLevel + 1) % levels.size())

func get_next_scene():
    var next_scene
    match currentLevel:
        0:
            next_scene = "res://Scenes/Cutscenes/ShopCutscene1.tscn"
        1:
            next_scene = "res://Scenes/Cutscenes/ShopCutscene2.tscn"
        2:
            next_scene = "res://Scenes/Cutscenes/ShopCutscene3.tscn"
        3:
            next_scene = "res://Scenes/Cutscenes/BossIntro.tscn"
    next_level()
    return next_scene
    
