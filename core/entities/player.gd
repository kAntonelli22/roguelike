class_name Player
extends Entity

#TODO switch to using target array to hold enemies that will be attacked
# ---- # Nodes
@onready var action_selection = $ActionSelection

# ---- # Variables
var current_attack: Attack

func toggle_selected():
   super()
   action_selection.visible = !action_selection.visible

func create_actions():
   for i in range(0, attacks.size()):
      var button = Button.new()
      button.text = attacks[i].name + " " + str(attacks[i].damage_min) + "-" + str(attacks[i].damage_max)
      button.name = str(i)
      action_selection.add_child(button)
      button.pressed.connect(attack_num.bind(button))

func attack_num(button):
   print_rich("[color=Royalblue]Player[/color]: attack button ", button, " pressed")
   var new_attack = attacks[button.name.to_int()]
   if current_attack == new_attack: current_attack = null
   else: current_attack = new_attack

func on_selected(selected_entity: Entity):
   if current_attack != null:
      if action_points > 0:
         current_attack.attack(selected_entity)
         set_state(states.attack)
      else: print_rich("[color=Royalblue]Player[/color]: not enough action points: ", action_points)
   elif selected_entity != self and is_selected:
         toggle_selected()

func _ready() -> void:
   base_class = Global.player_stats.base_class
   super()
   print_rich("[color=Royalblue]Player Created[/color]")
   add_to_group("Player")
   icon = Global.godot_icon
   health = Global.player_stats.health
   action_points = Global.player_stats.action_points
   SignalBus.connect("selected", on_selected)
   create_actions()
   await SignalBus.battle_ready
   SignalBus.emit_signal("new_player", self)
   

func _state_logic(_delta):
   super(_delta)
   
func _get_transition(_delta):
   super(_delta)

func _input(event: InputEvent) -> void:
   if !my_turn: return
   if event.is_action_pressed("ui_up"): set_state(states.attack)
   elif event.is_action_pressed("ui_down"): set_state(states.dead)

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int):
   super(viewport, event, shape_idx)
   if event.is_action_pressed("select"): print_rich("[color=Royalblue]Player[/color]: selected")
