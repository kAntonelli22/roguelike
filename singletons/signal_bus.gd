extends Node


# ---- # Battle Signals
signal battle_ready     # emitted by battle scene when it has connected its signals
signal turn_button_pressed    # called by the turn button when the player presses it
signal confirm_attack

# ---- # Entity Signals
signal new_player(player: Player)   # called by player in ready function
signal new_enemy(enemy: Enemy)      # called by enemy in ready function
signal entity_died(entity: Entity)  # called by entities when they die
signal end_turn(entity: Entity)     # called by a child of the batle scene when its turn is completed
signal selected(entity: Entity)     # called by an entity when the player selects them
signal target_selected(entity: Entity)    # called by selection manager when a target is added to target list
signal action(entity: Entity)       # called by an entity when the player presses the action button on them

func _ready() -> void:
   pass
   #connect("target_selected", debug)
#
#func debug(e):
   #print("signal received")
