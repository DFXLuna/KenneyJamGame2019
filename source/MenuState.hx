import flixel.FlxG;
import flixel.ui.FlxButton;
import flixel.FlxState;

class MenuState extends FlxState {
    var m_btnPlay: FlxButton;

    override public function create(): Void {
        super.create();
        m_btnPlay = new FlxButton(0, 0, "Play", clickPlay);
        m_btnPlay.screenCenter();
        add(m_btnPlay);
    }

    override public function update(elapsed: Float): Void {
        super.update(elapsed);
    }

    function clickPlay(): Void {
        FlxG.switchState(new PlayState());
    }

}