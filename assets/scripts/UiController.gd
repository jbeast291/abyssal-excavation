extends CanvasLayer

@onready var status_label: Label = $Panel/StatusLabel
@onready var progress_bar: ProgressBar = $ProgressBar

var initial_status_text: String;

func _ready() -> void:
	initial_status_text = status_label.text
	pass

func _physics_process(delta: float) -> void:
	status_label.text = get_status_text();
	progress_bar.value = 100 * (GameManager.main.oil_value / GameManager.main.total_oil_needed);
	pass

func get_status_text() -> String:
	var return_string: String = "";
	return_string = initial_status_text.replace("%oil%", String.num(GameManager.main.oil_value, 0));
	return_string = return_string.replace("%time%", String.num(GameManager.main.current_time, 1));
	return return_string;


#this code is shit, god awful, terrible, no good
#"why not just make it event based" THEY say
#but do THEY realize this is due in less than 24 hours??
#will THEY ever realize the truth?
#most don't. But on the offslight someone reads this nonsense
#congrats, really, I just keep rambling and your still reading,
#finding meaning in the abyss. 

## "Running on a fraying rope \ Placing steps with my eyes closed \ More at ease now that I know \ That I'll never reach the summit" - Tanger
## "THEY SAID: It's a question that you answer by turning turning turning [it] DOWN \ All the paths of life, no passerby \ will tell us the beautiful secrets of life. My death today wants me to SAY the things in my head everyday"\
## "A lifelong game of play pretend \ Now I don't know just who I am" - Treb
## "落ちて落ちて　落ちてゆこうよ \ いっしょに仲良くどこまでも" - Kikuo
## "Baby, now I'm ready, moving on \ Oh, but maybe I was ready all along" - Tame Impala
##"I'd rather be alone \ I really should have known" - Cafuné
