extends Node2D

var timer
var count = 0
var enemy = preload("res://Scenes/Enemies/Enemy.tscn")

# Called when the node enters the scene tree for the first time.
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
