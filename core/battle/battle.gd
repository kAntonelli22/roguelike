extends Node2D

# ---- # Nodes
@onready var ui: CanvasLayer = $UI

# ---- # Variables
var turn_queue: Array[Entity] = []    # use pop_front and push_back
var player_entities: Array[Entity] = []
var enemy_entities: Array[Entity] = []
var current_entity: Entity

func _ready() -> void:
   SignalBus.connect("end_turn", next_turn)
   SignalBus.connect("new_player", new_player)
   SignalBus.connect("new_enemy", new_enemy)
   SignalBus.emit_signal("battle_ready")
   #TODO listen for creation signals from Entity
   #TODO add Entitys into queues and arrays
   #TODO loop through entity arrays and determine turn order
   #TODO update ui order
   call_deferred("merge_arrays")

# ---- # Next Turn
# end current entities turn, place it at the end of the queue
# check if the game is over and update ui
# get the next entity and start its turn
func next_turn():
   current_entity.my_turn = false
   turn_queue.push_back(current_entity)
   
   if player_entities.is_empty(): print_rich("[color=Crimson]Game Over[/color]")
   elif enemy_entities.is_empty(): print_rich("[color=Green]You Won[/color]")
   ui.next_turn()
   
   current_entity = turn_queue.pop_front()
   current_entity.my_turn = true

# ---- # New Player
func new_player(player: Player):
   player_entities.append(player)
   print_rich("[color=#64649E]Battle Scene[/color]: [color=Royalblue]player[/color] added")

# ---- # New Enemy
func new_enemy(enemy: Enemy):
   enemy_entities.append(enemy)
   print_rich("[color=#64649E]Battle Scene[/color]: [color=Crimson]enemy[/color] added")

# ---- # Merge Arrays
func merge_arrays():
   print_rich("[color=#64649E]Battle Scene[/color]: merging arrays")
   turn_queue = player_entities
   turn_queue.append_array(enemy_entities)
   turn_queue.sort_custom(sort_queue)
   ui.update_queue(turn_queue)
   current_entity = turn_queue.pop_front()

# ---- # Sort Turn Queue
func sort_queue(e1: Entity, e2: Entity):
   if e1.speed > e2.speed: return true
   else: return false
