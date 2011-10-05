package
{
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.text.AntiAliasType;
    import flash.text.Font;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFormat;
    import flash.utils.getTimer;

    [SWF(width="800", height="600", backgroundColor="#000000")]
    public class Main extends Sprite
    {
        [Embed(source="veramono.ttf", fontName="_mono", mimeType="application/x-font", embedAsCFF="false")]
        private static const c_MonospaceFont:Class;

        private const m_UpdateInterval:uint = 250;

        private var m_Tick:int;
        private var m_UpdateTicks:uint;
        private var m_InfoTF:TextField;
        private var m_FPSTF:TextField;
        private var m_Stars:Array;

        public function Main():void
        {
            stage.frameRate = 60;

            m_Stars = new Array;
            for (var i:uint = 0; i < 512; i++)
                m_Stars.push(addChild(new Star(stage)));

            m_InfoTF = new TextField;
            m_InfoTF.embedFonts = true;
            m_InfoTF.defaultTextFormat = new TextFormat("_mono", 10, 0xffcc33);
            m_InfoTF.antiAliasType = AntiAliasType.ADVANCED;
            m_InfoTF.autoSize = TextFieldAutoSize.LEFT;
            m_InfoTF.background = true;
            m_InfoTF.backgroundColor = 0x000000;
            m_InfoTF.text = "Target Framerate: " + stage.frameRate + "\n" +
                            "Stars: " + m_Stars.length;
            m_InfoTF.x = 10;
            addChild(m_InfoTF);

            m_FPSTF = new TextField;
            m_FPSTF.embedFonts = true;
            m_FPSTF.defaultTextFormat = new TextFormat("_mono", 32, 0xffffff);
            m_FPSTF.antiAliasType = AntiAliasType.ADVANCED;
            m_FPSTF.autoSize = TextFieldAutoSize.LEFT;
            m_FPSTF.background = true;
            m_FPSTF.backgroundColor = 0x000000;
            m_FPSTF.x = 10;
            addChild(m_FPSTF);

            m_Tick = getTimer();
            m_UpdateTicks = 0;

            addEventListener(Event.ENTER_FRAME, Update);
        }

        public function Update(ev:Event):void
        {
            var t_now:int;
            var t_fps:uint;

            m_InfoTF.y = stage.stageHeight - m_InfoTF.height - 10;
            m_FPSTF.y = m_InfoTF.y - m_FPSTF.height - 10;

            m_UpdateTicks++;

            t_now = getTimer();
            if (t_now < m_Tick + m_UpdateInterval)
                return;

            t_fps = uint(m_UpdateTicks * (1000 / m_UpdateInterval));
            m_UpdateTicks = 0;

            m_FPSTF.text = t_fps + " fps";
            if (t_fps < 20)
                m_FPSTF.textColor = 0xff0000;
            else if (t_fps < 35)
                m_FPSTF.textColor = 0xffcc00;
            else
                m_FPSTF.textColor = 0x00ff00;

            m_Tick = t_now;
        }
    }
}