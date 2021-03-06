package
{
	import com.doitflash.consts.Easing;
	import com.doitflash.consts.Orientation;
	import com.doitflash.consts.ScrollConst;
	import com.doitflash.utils.scroll.TouchScroll;
	import com.gameanalytics.GALogEvent;
	import com.gameanalytics.GameAnalytics;
	import com.gameanalytics.constants.GAErrorSeverity;

	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.system.Capabilities;
	import flash.text.TextField;
	import flash.text.TextFormat;

	[SWF(width = '1200', height = '768', backgroundColor = "0xbad4ff")]
	public class GameAnalyticsExample extends Sprite
	{
		private static const SECRET_KEY:String = "d74b9cb1452aabda1353b655b5c427b792462284";
		private static const GAME_KEY:String = "4004a2e51024c13d99548424cfca3cc8";
		private static const GAME_VERSION:String = "1.0";

		private var buttonX:int = 50;
		private var checkBoxX:int = 50;
		private var buttons:Array = [];
		private var outPut:TextField;
		private var userInfo:TextField;
		private var scroller:TouchScroll;

		public function GameAnalyticsExample()
		{
			init();
		}

		private function init():void
		{
			createButton("Design Event", onDesignEvent);
			createButton("User Event", onUserEvent);
			createButton("Error Event", onErrorEvent);
			createButton("Business Event", onBusinessEvent);
			createButton("Send Events", onSendEvents);
			createButton("Delete events", onDeleteEvents);

			createCheckBox("Debug mode", onDebugModeCheckBox, true);
			createCheckBox("Editor mode", onEditorModeCheckBox);

			// output stuff
			userInfo = new TextField();
			userInfo.defaultTextFormat = new TextFormat("Arial", 12)
			userInfo.background = true;
			userInfo.backgroundColor = 0xffffff;
			userInfo.wordWrap = true;
			userInfo.multiline = true;
			userInfo.x = checkBoxX
			userInfo.y = 150;
			userInfo.width = 500;
			userInfo.height = 100;
			addChild(userInfo);

			outPut = new TextField();
			outPut.defaultTextFormat = new TextFormat("Arial", 12)
			outPut.background = true;
			outPut.backgroundColor = 0xffffff;
			outPut.wordWrap = true;
			outPut.multiline = true;
			outPut.width = 1150;
			outPut.height = 500;
			addChild(outPut);

			scroller = new TouchScroll();
			scroller.maskContent = outPut;
			scroller.enableVirtualBg = true;
			scroller.mouseWheelSpeed = 5;

			scroller.orientation = Orientation.VERTICAL; // accepted values: Orientation.AUTO, Orientation.VERTICAL, Orientation.HORIZONTAL
			scroller.easeType = Easing.Strong_easeOut;
			scroller.scrollSpace = 0;
			scroller.aniInterval = 1;
			scroller.mouseWheelSpeed = 2;
			scroller.isMouseScroll = false;
			scroller.isTouchScroll = true;
			scroller.bitmapMode = ScrollConst.NORMAL; // use it for smoother scrolling, special when working on mobile devices, accepted values: "normal", "weak", "strong"
			scroller.isStickTouch = false;
			scroller.holdArea = 0;

			scroller.x = 10;
			scroller.y = stage.stageHeight - 10 - outPut.height;
			scroller.maskWidth = 1150;
			scroller.maskHeight = 500;

			addChild(scroller);

			GameAnalytics.init(SECRET_KEY, GAME_KEY, GAME_VERSION);
			GameAnalytics.DEBUG_MODE = true;
			GameAnalytics.getLogEvents(onLogEvent);
			GameAnalytics.catchUnhandledExceptions(loaderInfo, true);

			showUserInfo();
		}

		private function showUserInfo():void
		{
			userInfo.appendText("User id: " + GameAnalytics.getUserId() + "\n");
			userInfo.appendText("Session id: " + GameAnalytics.getSessionId() + "\n");
			userInfo.appendText("OS: " + Capabilities.os + "\n");
			userInfo.appendText("Manufacturer: " + Capabilities.manufacturer + "\n");
			userInfo.appendText("Version: " + GameAnalytics.getVersion() + "\n");
		}

		private function createButton(text:String, callBackFunction:Function):void
		{
			var button:TestButton = new TestButton(text);
			button.addEventListener(MouseEvent.CLICK, callBackFunction);
			button.x = buttonX;
			button.y = 50;
			buttonX += button.width + 50;
			buttons.push(button);

			addChild(button);
		}

		private function createCheckBox(text:String, callBackFunction:Function, selected:Boolean = false):void
		{
			var checkBox:TestCheckBox = new TestCheckBox(text);
			checkBox.selected = selected;
			checkBox.addEventListener(MouseEvent.CLICK, callBackFunction);
			checkBox.x = checkBoxX;
			checkBox.y = 200;
			checkBoxX += checkBox.width + 50;

			addChild(checkBox);
		}

		private function onDesignEvent(e:MouseEvent):void
		{
			GameAnalytics.newDesignEvent("test_design_event", 10, "area 52");
		}

		private function onUserEvent(e:MouseEvent):void
		{
			GameAnalytics.newUserEvent("M", 1975, 100, "philarmon", "philarmon", "test", "test", "test", "test", "test", "test", "test");
		}

		private function onErrorEvent(e:MouseEvent):void
		{
			GameAnalytics.newErrorEvent("This is a test for the error event", GAErrorSeverity.CRITICAL, "Level 1", 100, 100, 0);
		}

		private function onBusinessEvent(e:MouseEvent):void
		{
			GameAnalytics.newBusinessEvent("test id", 10, "USD", "area1", 0, 1, 2);
		}

		private function onSendEvents(e:MouseEvent):void
		{
			GameAnalytics.sendData();
		}

		private function onDeleteEvents(e:MouseEvent):void
		{
			GameAnalytics.deleteAllEvents();
		}

		private function onDebugModeCheckBox(e:MouseEvent):void
		{
			e.currentTarget.selected = !e.currentTarget.selected;

			GameAnalytics.DEBUG_MODE = e.currentTarget.selected;
		}

		private function onEditorModeCheckBox(e:MouseEvent):void
		{
			e.currentTarget.selected = !e.currentTarget.selected;

			GameAnalytics.RUN_IN_EDITOR_MODE = e.currentTarget.selected;
		}

		private function onLogEvent(e:GALogEvent):void
		{
			addLog(e.text);
		}

		private function addLog(text:String, spaceBetweenLines:Boolean = true):void
		{
			outPut.appendText(text + (spaceBetweenLines ? "\n\n" : "\n"));
			outPut.height = outPut.textHeight + 20;
			scroller.yPerc = 100;
		}
	}
}
