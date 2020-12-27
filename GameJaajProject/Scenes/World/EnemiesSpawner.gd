extends Node2D

var timer
var count = 0
var enemy = preload("res://Scenes/Enemies/Goblin/Goblin.tscn")

func _ready():
    timer = $Timer
    timer.start()
    
func _process(delta):
    pass

func spawn_enemy():
    var clone = enemy.instance()
    add_child(clone)

func _on_Timer_timeout():
    spawn_enemy()
