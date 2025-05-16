extends Node

# ---- # Palette
# Black - White (#15151A), (#292933), (#3E3E4D), (#A3A3CC), (#B8B8E6), (#CCCCFF),
# Rich Print BBCode (Dimgray), (Springgreen), (Royalblue), (Dimgray), (Dimgray), (#64649E), 

var class_colors = {
   "abstract_fsm": "[color=#64649E]FSM[/color]",
   "battle": "[color=#64649E]Battle Scene[/color]",
   "entity": "[color=#64649E]Entity[/color]",
   "player": "[color=Royalblue]Player[/color]",
   "enemy": "[color=Crimson]Enemy[/color]",
   #"selection_manager": "[color=Springgreen]SelectionManager[/color]",
}

# ---- # debug print that uses class colors and adds the line it was called from
var left_padding: int = 0
var center_padding: int = 125

func _ready() -> void:
   for key in class_colors.keys():
      var key_value: String = class_colors[key].get_slice("]", 1)#.get_slice("[", 0)
      print(key_value)
      if key_value.length() > left_padding:
         left_padding = key_value.length()

#HACK bbcode in text causes formatting to be off
func print(args: Array, caller: String = ""):
   var stack = get_stack()
   var ln = -1
   var file_name = "Unknown"
   if stack.size() > 1:
      var caller_info = stack[1]
      ln = caller_info.line
      file_name = caller_info.source.get_file().get_basename()
   
   var text: String = ""
   for arg in args:
      text += str(arg)
   
   if !class_colors.has(file_name): return   # do not print if their is no class tag
   var printer: String = class_colors[file_name] + " | "
   var bbcode: int = printer.get_slice("]", 0).length() + 8 # closing bbcode bracket offset
   printer = printer.lpad(left_padding + bbcode)
   
   var final: String = printer + text
   var ln_name = " | " + file_name + ":" + str(caller) + ":" + str(ln)
   
   if text.length() <= center_padding:
      final = final.rpad(center_padding + bbcode)
      final += ln_name
      print_rich(final)
      return
   
   #FIXME doesnt function correctly
   var offset: int = 0
   while(text.length() > center_padding + printer.length()):
      var first = final.substr(0, center_padding + printer.length() + offset)
      var second = ".".lpad(bbcode-1) + " | " + final.substr(center_padding + text.length() + offset)
      final += first + " " + str(ln_name) + "\n" + second
      offset += first.length()
      text.erase(0, center_padding + printer.length())
   print_rich(final)
