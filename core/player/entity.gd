class_name Entity
extends StateMachine

# ---- # Nodes
@onready var sprite = $KnightSprite
@onready var healthbar = $Healthbar

# ---- # Variables
var selected: bool = true
var my_turn: bool = false

var health: int
var action_points: int
var speed: int             # used to determine turn

func attack(target: Entity, attack):
   target.health -= attack.damage

func _ready() -> void:
   print_rich("[color=#64649E]Entity Created[/color]")
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
      SignalBus.emit_signal("selected")
      print_rich("[color=#64649E]Entity[/color]: [color=#AAAAAA]selected by user")
