extends HBoxContainer

signal cooldown_over(id)

onready var buffIndicator = preload("res://Scenes/World/UI/BuffIndicator.tscn")
onready var spellIcons = {
    4: preload("res://Assets/Spells/Hexes/hex_shield.png")
}

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

func add_buff_effect(id):
    var clone = buffIndicator.instance()
    clone.texture = spellIcons[id]
    clone.rect_size = clone.texture.get_size()
    clone.spellID = id
    add_child(clone)
    
func remove_buff_effect(id):
    for effect in get_children():
        if (effect.spellID == id):
            effect.end_effect()
        break
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
