class_name Attack
extends Resource



var type: String
var name: String = "Base"
var cost: int = 1
var target_count: int = 1
var damage_min: int = 5
var damage_max: int = 10
var effects: Array[Effect]

func _init(
   p_name: String,
   p_cost: int,
   p_target_count: int,
   p_dam_min: int,
   p_dam_max: int,
   p_effects: Array[Effect]
) -> void:
   name = p_name
   cost = p_cost
   target_count = p_target_count
   damage_min = p_dam_min
   damage_max = p_dam_max
   effects = p_effects

func attack(targets: Array[Entity]):
   if targets.size() == 0:
      printerr("no targets")
      return
   for target in targets:
      target.apply_damage(range(damage_min, damage_max).pick_random())
      target.effects.append_array(effects)

class MultiCount:
   extends Attack
   
   var attack_count: int = 3
   func _init(
      p_name: String,
      p_cost: int,
      p_target_count: int,
      p_dam_min: int,
      p_dam_max: int,
      p_effects: Array[Effect],
      p_attack_count: int
   ) -> void:
      super(p_name, p_cost, p_target_count, p_dam_min, p_dam_max, p_effects)
      attack_count = p_attack_count
   
   func attack(targets: Array[Entity]):
      for i in range(0, attack_count):
         super([targets[0]])

class Heal extends Attack:
   func _init(
      p_name: String,
      p_cost: int,
      p_target_count: int,
      p_dam_min: int,
      p_dam_max: int,
      p_effects: Array[Effect],
   ) -> void:
      super(p_name, p_cost, p_target_count, p_dam_min, p_dam_max, p_effects)
   
   func attack(targets: Array[Entity]):
      targets[0].apply_damage(-range(damage_min, damage_max).pick_random())
      targets[0].effects.append_array(effects)
