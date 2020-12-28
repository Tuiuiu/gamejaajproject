extends Node2D

var spawner
var activeSpells
var player
var active_level

# Called when the node enters the scene tree for the first time.
func _ready():
    spawner = $Enemies
    activeSpells = $Spells
    player = $Player
    active_level = 0
    spawner.connect("level_over", self, "level_over_handler")
    start_level(active_level)

func reset():
    spawner.reset()
    for spell in activeSpells.get_children():
        spell.queue_free()

func start_level(level):
    spawner.start(level)

func level_over_handler():
    print("Level is Over! Reset and restart")
    reset()
    start_level(active_level)
