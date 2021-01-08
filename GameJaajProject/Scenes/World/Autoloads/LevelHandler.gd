extends Node

var currentLevel = 0
var levels = [
    [1.0, 3, 4.0, 0],
    [1.0, 2, 3.0, 0],
    [0.5, 0, 0.5, 1, 0.5, 0, 0.5, 1, 0.5, 0],
    [2.0, 0, 2.0, 1, 2.0, 0]
]

func _ready():
    pass # Replace with function body.

func get_level(level):
    return levels[level]
    
func get_current_level():
    return levels[currentLevel]    

func next_level():
    currentLevel = ((currentLevel + 1) % levels.size())
