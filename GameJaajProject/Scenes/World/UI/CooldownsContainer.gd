extends HBoxContainer

signal cooldown_over(id)

onready var spellCooldown = preload("res://Scenes/World/UI/SpellCooldowns.tscn")
onready var spellIcons = [
    preload("res://Assets/Spells/Red/rfb_icon.png"),
    preload("res://Assets/Spells/Black/bfb_icon.png"),
    preload("res://Assets/Spells/Green/gfb_icon.png"),
    "Flashlight",
    preload("res://Assets/Spells/Hexes/hex_shield.png")
]

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

func spell_over(id):
    emit_signal("cooldown_over", id)
    
func start_cooldown(id, cd):
    var clone = spellCooldown.instance()
    clone.texture = spellIcons[id]
    clone.rect_size = clone.texture.get_size()
    add_child(clone)
    clone.spell_cast(id, cd)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
