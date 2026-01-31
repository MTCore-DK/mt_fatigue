Locales = {
    en = {
        afk = 'You are now AFK',
        fatigue = 'You feel tired'
    }
}

function _L(key)
    return Locales[Config.Locale][key] or key
end
