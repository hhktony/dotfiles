require "modules/reload"
require "config"
require "modules/window"
require "modules/launcher"
require "modules/defaultInput"
-- require "modules/keychain"
-- require "modules/systemInfo"
-- require "modules/bluetoothSleep"

hs.hotkey.bind({'cmd', 'shift'}, 'x', function()
  hs.alert('Test online')
  speaker = hs.speech.new()
  speaker:speak("Hammerspoon is online")
  hs.notify.new({title="Hammerspoon launch", informativeText="Boss, at your service"}):send()
end)
