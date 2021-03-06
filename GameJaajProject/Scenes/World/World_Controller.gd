extends Node2D

var backgroundController
var foregroundController
var spawner
var activeSpells
var player
var player_sequence
var canvasModulator
var cooldownsHandler
var buffsHandler
var floorAnimator
var startingLevelHp
var GAME_MAX_TIME = 100.0
onready var runTimer = get_node("RunTimer")
onready var levelHandler = get_node("/root/LevelHandler")

# Called when the node enters the scene tree for the first time.
func _ready():
    spawner = $Enemies
    activeSpells = $Spells
    player = $Player
    player_sequence = $Player/SequenceDetector
    canvasModulator = $CanvasEffects
    cooldownsHandler = $UI/CanvasLayer/CooldownsContainer
    buffsHandler = $UI/CanvasLayer/BuffsContainer
    floorAnimator = $TileMap/AnimationPlayer
    backgroundController = $Background
    foregroundController = $Foreground
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
    startingLevelHp = levelHandler.last_HP
    reset(startingLevelHp)
    pause_game()
    start_level()
    
func reset(hp):
    pause_game()
    spawner.reset()
    for spell in activeSpells.get_children():
        spell.queue_free()
    floorAnimator.play("Down")
    player.reset(hp)
    resume_game()


func start_level():
    $Fader/AnimationPlayer.play("FadeIn")
    yield($Fader/AnimationPlayer, "animation_finished")
    player.change_state("run")
    player_sequence.sequences = {}
    player_sequence.sequences = levelHandler.get_spells()
    player_sequence.reset()
    player.change_health(levelHandler.last_HP)
    floorAnimator.play("Down")
    resume_motions()
    resume_game()
    spawner.start()
    runTimer.paused = false
    startingLevelHp = player.hp

func level_over_handler():
    #print("Level is Over! Reset and restart")
    player.deactivate()
    runTimer.paused = true
    var door = $TileMap/Door
    floorAnimator.play("Ending")
    door.play("Idle")
    yield(floorAnimator, "animation_finished")
    player.change_state("idle")
    stop_motions()
    door.play("Open")
    yield(door, "animation_finished")
    door.stop()
    $Fader/AnimationPlayer.play("FadeOut")
    yield($Fader/AnimationPlayer, "animation_finished")
    levelHandler.last_HP = player.hp
    levelHandler.last_max_hp = player.MAX_HP
    # Chamar o proximo level
    Global.goto_scene(levelHandler.get_next_scene())

func player_died_handler():
    stop_motions()
    #pause_game()
    $GenericTimer.wait_time = 5.0
    $GenericTimer.start()
    yield($GenericTimer, "timeout")
    $Fader/AnimationPlayer.play("FadeOut")
    yield($Fader/AnimationPlayer, "animation_finished")
    reset(startingLevelHp)
    start_level()

func _on_RunTimer_timeout():
    defeat()
    
func defeat():
    print ("SEM TEMPO, IRMÃO")
    #pause_game()

func pause_game():
    get_tree().paused = true
    
func resume_game():
    get_tree().paused = false
    
func flashlight_spell():
    canvasModulator.flashlight_spell()

func toll_the_dead():
    spawner.toll_the_dead()

func stop_motions():
    backgroundController.stop_motion()
    foregroundController.stop_motion()
    floorAnimator.stop(false)
    
func resume_motions():
    backgroundController.resume_motion()
    foregroundController.resume_motion()
    floorAnimator.play()
