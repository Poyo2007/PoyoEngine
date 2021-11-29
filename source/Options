package;

import Controls;
import Controls.Control;
import Controls.KeyboardScheme;
import flixel.input.keyboard.FlxKey;
import OptionCategory;
import Sys.sleep;
import flixel.FlxG;
import flash.events.KeyboardEvent;
import flixel.util.FlxSave;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;

//originally andromeda options code

class OptionUtils
{
	private static var saveFile:FlxSave = new FlxSave();
  
	public static var options:Options = new Options();
}

class Options
{
  //mobile things thingy thing thong
  public var opitionsnmobile:Bool = false;
  public var aboutkys:Bool = false;
}

class StateOption extends Option
{
	private var state:FlxState;
	public function new(name:String,state:FlxState){
		super();
		this.state=state;
		this.name=name;
	}
	public override function accept(){
		FlxG.switchState(state);
		return false;
	}
}

class Checkbox extends FlxSprite
{
	public var state:Bool=false;
	public var tracker:FlxSprite;
	public function new(state:Bool){
		super();
		this.state=state;
		frames = Paths.getSparrowAtlas("checkbox");
		updateHitbox();
		animation.addByIndices("unselected","confirm",[0],"",36,false);
		animation.addByPrefix("selecting","confirm",36,false);
		var reversedindices = []; // man i hate haxe I DONT WANNA DO A TABI CODE :(((
			// PROBABLY A BETTER WAY TO DO THIS
			// I DONT CARE IM BAD AT CODE
		var max = animation.getByName("selecting").frames.copy();
		max.reverse();
		for(i in max){
			reversedindices.push(i-2);
		}
		animation.addByIndices("unselecting","confirm",reversedindices,"",36,false);
		animation.addByIndices("selected","confirm",[animation.getByName("selecting").frames.length-2],"",36,false);
		antialiasing=true;
		setGraphicSize(Std.int(width*.6) );
		updateHitbox();
		if(state)
			animation.play("selected");
		else
			animation.play("unselected");

	}

	public function changeState(state:Bool){
		this.state=state;
		if(state){
			animation.play("selecting",true,false,animation.curAnim.name=='unselecting'?animation.curAnim.frames.length-animation.curAnim.curFrame:0);
		}else{
			animation.play("unselecting",true,false,animation.curAnim.name=='selecting'?animation.curAnim.frames.length-animation.curAnim.curFrame:0);
		}
	}

	override function update(elapsed:Float){
		super.update(elapsed);
		if(tracker!=null){
			x = tracker.x - 140;
			y = tracker.y - 45;
		}
		if(animation.curAnim!=null){

			if(animation.curAnim.finished && (animation.curAnim.name=="selecting" || animation.curAnim.name=="unselecting")){
				if(state){
					trace("SELECTED");
					animation.play("selected",true);
				}else{
					trace("UNSELECTED");
					animation.play("unselected",true);
				}
			}

			switch(animation.curAnim.name){
				case 'selecting' | 'unselecting':
					//offset.x=18;
					//offset.y=70;
					offset.x=0;
					offset.y=0;
				case 'unselected':
					//offset.x=0;
					//offset.y=0;
					offset.x=0;
					offset.y=0;
				case 'selected':
					//offset.x=10;
					//offset.y=49.7;
					offset.x=0;
					offset.y=0;
			}
		}

	}
}

class ToggleOption extends Option
{
	private var property = "dummy";
	private var checkbox:Checkbox;
	public function new(property:String,?name:String,?description:String=''){
		super();
		this.property = property;
		this.name = name;
		this.description=description;
		checkbox = new Checkbox(Reflect.field(OptionUtils.options,property));
		add(checkbox);
	}

	public override function createOptionText(curSelected:Int,optionText:FlxTypedGroup<Option>):Dynamic{
    remove(text);
    text = new Alphabet(0, (70 * curSelected) + 30, name, true, false);
    text.movementType = "list";
    text.isMenuItem = true;
		text.offsetX = 165;
		text.gotoTargetPosition();
		checkbox.tracker = text;
    add(text);
    return text;
  }

	public override function accept():Bool{
		Reflect.setField(OptionUtils.options,property,!Reflect.field(OptionUtils.options,property));
		checkbox.changeState(Reflect.field(OptionUtils.options,property));

		return false;
	}
}

class StepOption extends Option
{
	private var property = "dummyInt";
	private var defaultName = "default";
	private var max:Float = 100;
	private var min:Float = 0;
	private var step:Float = 0;
	private var suffix:String='';
	private var prefix:String='';


	private var leftArrow:FlxSprite;
	private var rightArrow:FlxSprite;
	public function new(property:String,name:String,?step:Float=1,?min:Float=0,?max:Float=100,?suffix:String='',?prefix:String='',?desc:String=''){
		super();
		this.property=property;
		this.defaultName = name;
		this.step=step;
		this.min=min;
		this.max=max;
		this.suffix=suffix;
		this.prefix=prefix;
		this.description=desc;

		var value = Reflect.field(OptionUtils.options,property);
		leftArrow = new FlxSprite(0,0);
		leftArrow.frames = Paths.getSparrowAtlas("arrows");
		leftArrow.setGraphicSize(Std.int(leftArrow.width*.7));
		leftArrow.updateHitbox();
		leftArrow.animation.addByPrefix("pressed","arrow push left",24,false);
		leftArrow.animation.addByPrefix("static","arrow left",24,false);
		leftArrow.animation.play("static");

		rightArrow = new FlxSprite(0,0);
		rightArrow.frames = Paths.getSparrowAtlas("arrows");
		rightArrow.setGraphicSize(Std.int(rightArrow.width*.7));
		rightArrow.updateHitbox();
		rightArrow.animation.addByPrefix("pressed","arrow push right",24,false);
		rightArrow.animation.addByPrefix("static","arrow right",24,false);
		rightArrow.animation.play("static");

		add(rightArrow);
		add(leftArrow);

		this.name = '${defaultName} ${prefix}${value}${suffix}';

	};

	override function update(elapsed:Float){
		super.update(elapsed);
		//sprTracker.x + sprTracker.width + 10
		if(PlayerSettings.player1.controls.LEFT){
			leftArrow.animation.play("pressed");
			leftArrow.offset.x = 0;
			leftArrow.offset.y = -3;
		}else{
			leftArrow.animation.play("static");
			leftArrow.offset.x = 0;
			leftArrow.offset.y = 0;
		}

		if(PlayerSettings.player1.controls.RIGHT){
			rightArrow.animation.play("pressed");
			rightArrow.offset.x = 0;
			rightArrow.offset.y = -3;
		}else{
			rightArrow.animation.play("static");
			rightArrow.offset.x = 0;
			rightArrow.offset.y = 0;
		}
		rightArrow.x = text.x+text.width+10;
		leftArrow.x = text.x-60;
		leftArrow.y = text.y-10;
		rightArrow.y = text.y-10;
	}

	public override function createOptionText(curSelected:Int,optionText:FlxTypedGroup<Option>):Dynamic{
    remove(text);
    text = new Alphabet(0, (70 * curSelected) + 30, name, true, false);
    text.movementType = "list";
    text.isMenuItem = true;
		text.offsetX = 135;
		text.gotoTargetPosition();
    add(text);
    return text;
  }

	public override function left():Bool{
		var value:Float = Reflect.field(OptionUtils.options,property)-this.step;

		if(value<min)
			value=max;

		if(value>max)
			value=min;

		Reflect.setField(OptionUtils.options,property,value);
		name = '${defaultName} ${prefix}${value}${suffix}';

		return true;
	};
	public override function right():Bool{
		var value:Float = Reflect.field(OptionUtils.options,property)+this.step;

		if(value<min)
			value=max;
		if(value>max)
			value=min;

		Reflect.setField(OptionUtils.options,property,value);

		name = '${defaultName} ${prefix}${value}${suffix}';
		return true;
	};
}

class ControlOption extends Option
{
	private var controlType:Control = Control.UP;
	private var controls:Controls;
	private var key:FlxKey;
	public var forceUpdate=false;
	public function new(controls:Controls,controlType:Control){
		super();
		this.controlType=controlType;
		this.controls=controls;
		key=OptionUtils.getKey(controlType);
		name='${controlType} : ${OptionUtils.getKey(controlType).toString()}';
	};

	public override function keyPressed(pressed:FlxKey){
		//FlxKey.fromString(String.fromCharCode(event.charCode));
		for(k in OptionUtils.shit){
			if(pressed==k){
				pressed=-1;
				break;
			};
		};
		if(pressed!=ESCAPE){
			OptionUtils.options.controls[OptionUtils.getKIdx(controlType)]=pressed;
			key=pressed;
		}
		name='${controlType} : ${OptionUtils.getKey(controlType).toString()}';
		if(pressed!=-1){
			trace("epic style " + pressed.toString() );
			controls.setKeyboardScheme(Custom,true);
			allowMultiKeyInput=false;
			return true;
		}
		return true;
	}

	public override function createOptionText(curSelected:Int,optionText:FlxTypedGroup<Option>):Dynamic{
    remove(text);
    text = new Alphabet(0, (70 * curSelected) + 30, name, false, false);
    text.movementType = "list";
		text.offsetX = 70;
    text.isMenuItem = true;
		text.gotoTargetPosition();
    add(text);
    return text;
  }

	public override function accept():Bool{
		controls.setKeyboardScheme(None,true);
		allowMultiKeyInput=true;
		//FlxG.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		name = "<Press any key to rebind>";
		return true;
	};
}
