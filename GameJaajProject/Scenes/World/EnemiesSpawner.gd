extends Node2D

#onready var countMax = 3
onready var waitTime = 2.0
var timer
var countLeft
var enemiesList
var enemies = [preload("res://Scenes/Enemies/Goblin/Goblin.tscn")]
var levelHandler

signal level_over

func _ready():
    timer = $Timer
    levelHandler = get_node("/root/LevelHandler")
    
func _process(delta):
    if (countLeft == 0):
        if (get_child_count() == 1):
            countLeft = -1
            emit_signal("level_over")

func spawn_enemy(enemyIndex):
    var clone = enemies[enemyIndex].instance()
    add_child(clone)

func start():
    countLeft = 1
    spawn_level()

func reset():
    for enemy in self.get_children():
        if (enemy.name != "Timer"):
            enemy.queue_free()

func spawn_level():
    enemiesList = levelHandler.get_current_level()
    for i in range(enemiesList.size()/2):
        var index = 2*i
        timer.wait_time = enemiesList[index]
        timer.start()
        yield($Timer, "timeout")
        spawn_enemy(enemiesList[index+1])
    countLeft = 0
