package;

import flixel.graphics.FlxGraphic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class OptionsSubState extends MusicBeatSubstate
{
	var textMenuItems:Array<String> = [(FlxG.save.data.ghostTap ? 'Ghost Tapping' : 'No Ghost Tapping'), (FlxG.save.data.downscroll ? 'Downscroll' : 'Upscroll'), (FlxG.save.data.middlescroll ? 'MiddleScroll' : 'No MiddleScroll'), (FlxG.save.data.moreInfo ? 'More Info' : 'Minimal Info')];

	var selector:FlxSprite;
	var curSelected:Int = 0;

	var grpOptionsTexts:FlxTypedGroup<FlxText>;

	var explainThing:FlxText;

	public function new()
	{
		super();

		grpOptionsTexts = new FlxTypedGroup<FlxText>();
		add(grpOptionsTexts);

		/*var explainBG:FlxSprite;
		add(explainBG);
		explainBG.makeGraphic(FlxG.width, 100, 0xFFFFFFFF);
		explainBG.x = 0;
		explainBG.y = FlxG.height - 18;*/
		

		explainThing = new FlxText(0, FlxG.height - 18, 0, 'a', 32);
		add(explainThing);

		for (i in 0...textMenuItems.length)
		{
			var optionText:FlxText = new FlxText(20, 20 + (i * 50), 0, textMenuItems[i], 32);
			optionText.setFormat(Paths.font("vcr.ttf"), 64, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			optionText.ID = i;
			grpOptionsTexts.add(optionText);
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.UP_P)
			curSelected -= 1;

		if (controls.DOWN_P)
			curSelected += 1;

		if (curSelected < 0)
			curSelected = textMenuItems.length - 1;

		if (curSelected >= textMenuItems.length)
			curSelected = 0;

		grpOptionsTexts.forEach(function(txt:FlxText)
		{
			txt.color = FlxColor.WHITE;

			if (txt.ID == curSelected)
				txt.color = FlxColor.YELLOW;
		});

		switch (curSelected)
		{
			case 0:
				explainThing.text = 'Determines If you get a miss when you hit a non-existant note or not';
			case 1:
				explainThing.text = 'Determines If the notes scroll up or down (NOT IN YET)';
			case 2:
				explainThing.text = 'Determines If your strumline is in the middle or on the right';
			case 3:
				explainThing.text = 'Determines If score text shows misses and etc';
		}

		if (controls.ACCEPT)
		{
			switch (curSelected)
			{
				case 0:
					FlxG.save.data.ghostTap = !FlxG.save.data.ghostTap;
                    grpOptionsTexts.forEach(function(txt:FlxText)
                    {
                        if (txt.ID == curSelected)
                            txt.text = (FlxG.save.data.ghostTap ? 'Ghost Tapping' : 'No Ghost Tapping');
                    });
				case 1:
					FlxG.save.data.downscroll = !FlxG.save.data.downscroll;
                    grpOptionsTexts.forEach(function(txt:FlxText)
                    {
                        if (txt.ID == curSelected)
                            txt.text = (FlxG.save.data.downscroll ? 'Downscroll' : 'Upscroll');
                    });
				case 2:
					FlxG.save.data.middlescroll = !FlxG.save.data.middlescroll;
                    grpOptionsTexts.forEach(function(txt:FlxText)
                    {
                        if (txt.ID == curSelected)
                            txt.text = (FlxG.save.data.middlescroll ? 'MiddleScroll' : 'No MiddleScroll');
                    });
				case 3:
					FlxG.save.data.moreInfo = !FlxG.save.data.moreInfo;
                    grpOptionsTexts.forEach(function(txt:FlxText)
                    {
                        if (txt.ID == curSelected)
                            txt.text = (FlxG.save.data.moreInfo ? 'More Info' : 'Minimal Info');
                    });
			}
		}
	}
}
