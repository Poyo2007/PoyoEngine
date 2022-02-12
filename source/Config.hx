package;

import ui.FlxVirtualPad;
import flixel.FlxG;
import flixel.util.FlxSave;
import flixel.math.FlxPoint;

class Config {
    var save:FlxSave;

    public function new() 
    {
        save = new FlxSave();
    	save.bind("saveconrtol");
    }

    public function setdownscroll(?value:Bool):Bool {
		if (save.data.isdownscroll == null) save.data.isdownscroll = false;
		
		save.data.isdownscroll = !save.data.isdownscroll;
		save.flush();
        return save.data.isdownscroll;
	}

    public function getdownscroll():Bool {
        if (save.data.isdownscroll != null) return save.data.isdownscroll;
        return false;
    }
    
    public function setsusmode(?value:Bool):Bool {
		if (save.data.susmode == null) save.data.susmode = false;
		
		save.data.susmode = !save.data.susmode;
		save.flush();
        return save.data.susmode;
	}

    public function getsusmode():Bool {
        if (save.data.susmode != null) return save.data.susmode;
        return false;
    }
    
    public function setsplitassets(?value:Bool):Bool {
		if (save.data.assetsplit == null) save.data.assetsplit = false;
		
		save.data.assetsplit = !save.data.assetsplit;
		save.flush();
        return save.data.assetsplit;
	}

    public function getsplitassets():Bool {
        if (save.data.assetsplit != null) return save.data.assetsplit;
        return false;
    }
    
    public function sethitsound(?value:Bool):Bool {
		if (save.data.usehitsound == null) save.data.usehitsound = false;
		
		save.data.usehitsound = !save.data.usehitsound;
		save.flush();
        return save.data.usehitsound;
	}

    public function gethitsound():Bool {
        if (save.data.usehitsound != null) return save.data.usehitsound;
        return false;
    }

    public function setnodialogue(?value:Bool):Bool {
		if (save.data.nodialogue == null) save.data.nodialogue = false;
		
		save.data.nodialogue = !save.data.nodialogue;
		save.flush();
        return save.data.nodialogue;
	}

    public function getnodialogue():Bool {
        if (save.data.nodialogue != null) return save.data.nodialogue;
        return false;
    }
    
    public function setnobg(?value:Bool):Bool {
		if (save.data.nobg == null) save.data.nobg = false;
		
		save.data.nobg = !save.data.nobg;
		save.flush();
        return save.data.nobg;
	}

    public function getnobg():Bool {
        if (save.data.nobg != null) return save.data.nobg;
        return false;
    }
    
   public function setmidscroll(?value:Bool):Bool {
		if (save.data.midscroll == null) save.data.midscroll = false;
		
		save.data.midscroll = !save.data.midscroll;
		save.flush();
        return save.data.midscroll;
	}

    public function getmidscroll():Bool {
        if (save.data.midscroll != null) return save.data.midscroll;
        return false;
    }
    
    public function setcircles(?value:Bool):Bool {
		if (save.data.circles == null) save.data.circles = false;
		
		save.data.circles = !save.data.circles;
		save.flush();
        return save.data.circles;
	}

    public function getcircles():Bool {
        if (save.data.circles != null) return save.data.circles;
        return false;
    }
    
    public function setnochar(?value:Bool):Bool {
		if (save.data.nochar == null) save.data.nochar = false;
		
		save.data.nochar = !save.data.nochar;
		save.flush();
        return save.data.nochar;
	}

    public function getnochar():Bool {
        if (save.data.nochar != null) return save.data.nochar;
        return false;
    }

    public function getcontrolmode():Int {
        // load control mode num from FlxSave
		if (save.data.buttonsmode != null) return save.data.buttonsmode[0];
        return 0;
    }

    public function setcontrolmode(mode:Int = 0):Int {
        // save control mode num from FlxSave
		if (save.data.buttonsmode == null) save.data.buttonsmode = new Array();
        save.data.buttonsmode[0] = mode;
        save.flush();

        return save.data.buttonsmode[0];
    }

    public function savecustom(_pad:FlxVirtualPad) {
		trace("saved");

		if (save.data.buttons == null)
		{
			save.data.buttons = new Array();

			for (buttons in _pad)
			{
				save.data.buttons.push(FlxPoint.get(buttons.x, buttons.y));
			}
		}else
		{
			var tempCount:Int = 0;
			for (buttons in _pad)
			{
				save.data.buttons[tempCount] = FlxPoint.get(buttons.x, buttons.y);
				tempCount++;
			}
		}
		save.flush();
	}

	public function loadcustom(_pad:FlxVirtualPad):FlxVirtualPad {
		//load pad
		if (save.data.buttons == null) return _pad;
		var tempCount:Int = 0;

		for(buttons in _pad)
		{
			buttons.x = save.data.buttons[tempCount].x;
			buttons.y = save.data.buttons[tempCount].y;
			tempCount++;
		}	
        return _pad;
	}
}