extends Node2D

var spawner
var activeSpells
var player
var canvasModulator
var cooldownsHandler
var buffsHandler
var floorAnimator
var GAME_MAX_TIME = 100.0
onready var runTimer = get_node("RunTimer")
onready var levelHandler = get_node("/root/LevelHandler")

# Called when the node enters the scene tree for the first time.
func _ready():
    spawner = $Enemies
    activeSpells = $Spells
    player = $Player
    canvasModulator = $CanvasEffects
    cooldownsHandler = $UI/CanvasLayer/CooldownsContainer
    buffsHandler = $UI/CanvasLayer/BuffsContainer
    floorAnimator = $TileMap/AnimationPlayer
    runTimer.wait_time = GAME_MAX_TIME
    runTimer.paused = true
    runTimer.start()
    spawner.connect("level_over", self, "level_over_handler")
    player.connect("player_died", self, "player_died_handler")
    player.connect("spell_cast", cooldownsHandler, "start_cooldown")
    player.connect("add_buff", buffsHandler, "add_buff_effect")
    player.connect("remove_buff", buffsHandler, "remove_buff_effect")
    cooldownsHandler.connect("cooldown_over", player, "cooldown_over_handler")
    floorAnimator.play("Down")
    start_level()
    
func reset():
    pause_game()
    spawner.reset()
    for spell in activeSpells.get_children():
        spell.queue_free()
    floorAnimator.play("Down")
    resume_game()

func start_level():
    resume_game()
    spawner.start()
    runTimer.paused = false

func level_over_handler():
    print("Level is Over! Reset and restart")
    #floorAnimator.play("Down")
    #yield(floorAnimator, "animation_finished")
    floorAnimator.play("Ending")
    yield(floorAnimator, "animation_finished")
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

func player_died_handler():
    pause_game()

func flashlight_spell():
    canvasModulator.flashlight_spell()

func toll_the_dead():
    spawner.toll_the_dead()
