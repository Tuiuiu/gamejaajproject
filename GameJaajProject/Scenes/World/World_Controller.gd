extends Node2D

var spawner
var activeSpells
var player
var GAME_MAX_TIME = 100.0
onready var runTimer = get_node("RunTimer")
onready var levelHandler = get_node("/root/LevelHandler")

# Called when the node enters the scene tree for the first time.
func _ready():
    spawner = $Enemies
    activeSpells = $Spells
    player = $Player
    runTimer.wait_time = GAME_MAX_TIME
    runTimer.paused = true
    runTimer.start()
    spawner.connect("level_over", self, "level_over_handler")
    start_level()
    
func reset():
    spawner.reset()
    for spell in activeSpells.get_children():
        spell.queue_free()

func start_level():
    spawner.start()
    runTimer.paused = false

func level_over_handler():
    print("Level is Over! Reset and restart")
    runTimer.paused = true
    reset()
    levelHandler.next_level()
    start_level()

func _on_RunTimer_timeout():
    defeat()
    
func defeat():
    print ("SEM TEMPO, IRMÃO")
    pause_game()

func pause_game():
    get_tree().paused = true
    
func resume_game():
    get_tree().paused = false
