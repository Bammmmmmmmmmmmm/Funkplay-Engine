package;

import flixel.FlxState;
import flixel.FlxG;

class KeyBinds extends FlxState
{
    var controls:Array<String> = CoolUtil.coolTextFile(Paths.txt('gameControls'));
    override public function create():Void
    {
        super.create();
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
    }
}