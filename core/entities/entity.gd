class_name Entity
extends StateMachine

#TODO attack class that entities reference
#TODO weapon class that entities reference
#TODO only one entity selected at a time

# ---- # Nodes
@onready var sprite := $Sprite
@onready var healthbar := $Healthbar
@onready var selection_ring := $SelectionRing

# ---- # Variables
var icon 

var is_selected: bool = false
var my_turn: bool = false

var base_class: String = "Knight"
var health: int = 100
var action_points: int = 3
var speed: int             # used to determine turn
var attacks: Array[Attack]

func toggle_selected():
   is_selected = !is_selected
   selection_ring.visible = !selection_ring.visible

func apply_damage(damage):
   health -= damage
   #TODO shake sprite around for a second

func _ready() -> void:
   print_rich("[color=#64649E]Entity Created[/color]")
   print("healthbar: ", healthbar.value, " ", health)
   sprite.sprite_frames = Global.classes[base_class]["sprite"]
   attacks = Global.classes[base_class]["attacks"]
   add_to_group("Entity")
   add_state("idle")
   add_state("attack")
   add_state("dead")
   sprite.play("idle")
   speed = get_tree().get_nodes_in_group("Entity").size()

func _state_logic(_delta):
   if !my_turn: return
   if healthbar.value != health: healthbar.value = health
   match(state):
      states.idle:
         if sprite.animation != "idle": sprite.play("idle")
      states.attack:
         if sprite.animation != "attack": sprite.play("attack")
      states.dead:
         if sprite.animation != "dead" and sprite.is_playing(): sprite.play("die")
   
func _get_transition(_delta):
   pass

func _on_knight_sprite_animation_looped() -> void:
   if state == states.attack: set_state(states.idle)

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
   if event.is_action_pressed("select"):
      toggle_selected()
      if !is_selected: SignalBus.emit_signal("selected", self)
