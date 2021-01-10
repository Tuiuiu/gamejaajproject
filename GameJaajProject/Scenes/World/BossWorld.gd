extends Node2D

var spawner
var activeSpells
var player
var canvasModulator
var cooldownsHandler
var buffsHandler
var boss
var startingLevelHp
onready var levelHandler = get_node("/root/LevelHandler")

# Called when the node enters the scene tree for the first time.
func _ready():
    spawner = $Enemies
    boss = $Enemies/BlackBoss
    activeSpells = $Spells
    player = $Player
    canvasModulator = $CanvasEffects
    cooldownsHandler = $UI/CanvasLayer/CooldownsContainer
    buffsHandler = $UI/CanvasLayer/BuffsContainer
    boss.connect("boss_dead", self, "boss_dead_handler")
    player.connect("player_died", self, "player_died_handler")
    player.connect("spell_cast", cooldownsHandler, "start_cooldown")
    player.connect("add_buff", buffsHandler, "add_buff_effect")
    player.connect("remove_buff", buffsHandler, "remove_buff_effect")
    cooldownsHandler.connect("cooldown_over", player, "cooldown_over_handler")
    pause_game()
    start_level()
    
func reset(hp):
    boss.reset()
    player.reset(hp)
    for spell in activeSpells.get_children():
        spell.queue_free()


func start_level():
    $Fader/AnimationPlayer.play("FadeIn")
    yield($Fader/AnimationPlayer, "animation_finished")
    startingLevelHp = player.hp
    player.start_boss_fight(startingLevelHp)
    boss.start()
    resume_game()

func boss_dead_handler():
    print("Level is Over! Reset and restart")
    player.deactivate()
    player.change_state("idle")
    stop_motions()
    $Fader/AnimationPlayer.play("FadeOut")
    yield($Fader/AnimationPlayer, "animation_finished")
    Global.goto_scene("res://Scenes/Cutscenes/EndCutscene.tscn")

func defeat():
    print ("SEM TEMPO, IRMÃO")
    #pause_game()

func pause_game():
    get_tree().paused = true
    
func resume_game():
    get_tree().paused = false

func player_died_handler():
    stop_motions()
    $GenericTimer.wait_time = 5.0
    $GenericTimer.start()
    yield($GenericTimer, "timeout")
    $Fader/AnimationPlayer.play("FadeOut")
    yield($Fader/AnimationPlayer, "animation_finished")
    pause_game()
    reset(startingLevelHp)
    start_level()

func flashlight_spell():
    canvasModulator.flashlight_spell()

func toll_the_dead():
    spawner.toll_the_dead()

func stop_motions():
    pass
    
func resume_motions():
    pass
