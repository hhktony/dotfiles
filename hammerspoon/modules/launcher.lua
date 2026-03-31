hs.fnutils.each(apps, function(app)
    if app.shortcut then  -- Only bind shortcuts for apps that have them defined
        hs.hotkey.bind(kb.app, app.shortcut, app.name, function()
            hs.application.launchOrFocus(app.name)
        end)
    end
end)
