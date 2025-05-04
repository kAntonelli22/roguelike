extends Node2D

#TODO implement a spot system to allow players to decide where their members are placed
#TODO replace debug entity creation with party resource based entity creation

# ---- # Nodes
@onready var ui: CanvasLayer = $UI

# ---- # Variables
var turn_count: int = 0
var turn_queue: Array[Entity] = []    # use pop_front and push_back
var player_entities: Array[Player] = []
var enemy_entities: Array[Enemy] = []
var current_entity: Entity

func _ready() -> void:
   SignalBus.connect("end_turn", next_turn)
   SignalBus.connect("new_player", new_player)
   SignalBus.connect("new_enemy", new_enemy)
   SignalBus.connect("entity_died", remove_from_queue)
   SignalBus.emit_signal("battle_ready")
   call_deferred("merge_arrays")

# ---- # Next Turn
# end current entities turn, place it at the end of the queue
# check if the game is over and update ui
# get the next entity and start its turn
func next_turn():
   turn_count += 1
   current_entity.my_turn = false
   turn_queue.push_back(current_entity)
   
   current_entity = turn_queue.pop_front()
   @warning_ignore("standalone_ternary")
   ui.next_turn(true) if current_entity is Enemy else ui.next_turn(false)
   current_entity.my_turn = true
   SelectionManager.select_entity(current_entity)
   Util.print([current_entity.name, " beginning turn"])

# ---- # New Player
func new_player(player: Player):
   player_entities.append(player)
   Util.print(["[color=Royalblue]player[/color] added"])
   #print_rich("[color=#64649E]Battle Scene[/color]: [color=Royalblue]player[/color] added")

# ---- # New Enemy
func new_enemy(enemy: Enemy):
   enemy_entities.append(enemy)
   Util.print(["[color=Crimson]enemy[/color] added"])
   #print_rich("[color=#64649E]Battle Scene[/color]: [color=Crimson]enemy[/color] added")

# ---- # Remove From Queue
func remove_from_queue(entity: Entity):   
   if entity is Player:
      var p_index: int = player_entities.find(entity)
      if p_index == -1: return
      player_entities.remove_at(p_index)
   if entity is Enemy:
      var e_index: int = enemy_entities.find(entity)
      if e_index == -1: return
      enemy_entities.remove_at(e_index)
   
   var index = turn_queue.find(entity)
   if index != -1: turn_queue.remove_at(index)
   ui.remove_from_queue(entity)
   
   if player_entities.is_empty() or enemy_entities.is_empty(): end_battle()

# ---- # Merge Arrays
func merge_arrays():
   turn_queue.assign(player_entities)
   turn_queue.append_array(enemy_entities)
   turn_queue.sort_custom(sort_queue)
   ui.update_queue(turn_queue)
   current_entity = turn_queue.pop_front()
   current_entity.my_turn = true

# ---- # Sort Turn Queue
func sort_queue(e1: Entity, e2: Entity):
   if e1.speed < e2.speed: return true    #HACK temporary < until an actual speed system is implemented
   else: return false

# ---- # End Battle
func end_battle():
   Global.player_stats.campaign_position += 1
   SelectionManager.reset()
   get_tree().change_scene_to_packed(Global.map_scene)
