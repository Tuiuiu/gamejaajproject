extends Node2D

var spawner
var activeSpells
var player
onready var levelHandler = get_node("/root/LevelHandler")

# Called when the node enters the scene tree for the first time.
func _ready():
    spawner = $Enemies
    activeSpells = $Spells
    player = $Player
    spawner.connect("level_over", self, "level_over_handler")
    start_level()

func reset():
    spawner.reset()
    for spell in activeSpells.get_children():
        spell.queue_free()

func start_level():
    spawner.start()

func level_over_handler():
    print("Level is Over! Reset and restart")
    reset()
    levelHandler.next_level()
    start_level()
