extends Node2D

onready var countMax = 3
onready var waitTime = 2.0
var timer
var countLeft
onready var enemy = preload("res://Scenes/Enemies/Goblin/Goblin.tscn")

signal level_over

func _ready():
    timer = $Timer
    #timer.start()
    
func _process(delta):
    if (countLeft == 0):
        if (get_child_count() == 1):
            countLeft = -1
            emit_signal("level_over")

func spawn_enemy():
    if (countLeft > 0):
        var clone = enemy.instance()
        countLeft -= 1
        add_child(clone)
        if (countLeft == 0):
            timer.stop()
        
func _on_Timer_timeout():
    spawn_enemy()

func start(level):
    countLeft = countMax
    timer.wait_time = waitTime
    timer.start()

func reset():
    for enemy in self.get_children():
        if (enemy.name != "Timer"):
            enemy.queue_free()
