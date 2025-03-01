-- Вебхук-ссылка
local webhook = "https://discord.com/api/webhooks/1323066038778069104/aw-JU7tPlGWcZMUQR08rMU9RhNgIY3eZnH7726xNwHC6_2g48pllg5FQORbNmQ9xkf6y"

-- Метод для отправки HTTP-запросов
local httprequest = (syn and syn.request) or http and http.request or http_request or (fluxus and fluxus.request) or request

-- Служба для работы с HTTP
local HttpService = game:GetService("HttpService")

-- Функция для отправки вебхука с файлом
local function sendWebhookWithFile(fileContent, fileName)
    if not webhook then
        return
    end

    -- Формируем тело запроса с файлом
    local boundary = "----WebKitFormBoundary7MA4YWxkTrZu0gW"
    local body = "--" .. boundary .. "\r\n"
    body = body .. 'Content-Disposition: form-data; name="file"; filename="' .. fileName .. '"\r\n'
    body = body .. "Content-Type: text/plain\r\n\r\n"
    body = body .. fileContent .. "\r\n"
    body = body .. "--" .. boundary .. "--\r\n"

    -- Отправляем вебхук с файлом
    httprequest({
        Url = webhook,
        Body = body,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "multipart/form-data; boundary=" .. boundary,
            ["Content-Length"] = tostring(#body)
        }
    })
end

-- Функция для вычисления урона
local function Calculate(Damage, Level)
    return math.floor(Damage * (1 + (Level - 1) * 8.2 / 100))
end

-- Форматирование чисел
local function format(number)
    local i, j, minus, int, fraction = tostring(number):find('([-]?)(%d+)([.]?%d*)')
    int = int:reverse():gsub("(%d%d%d)", "%1,")
    return minus .. int:reverse():gsub("^,", "")
end

-- Данные юнитов
local Units = {
    ["Shadowgirl (Time Traveller)"] = {
        Damage = Calculate(12510, 110),
        SPA = 6,
        Range = 32,
        Placements = 3
    },
    ["Veko "] = {
        Damage = Calculate(2000, 110),
        SPA = 6,
        Range = 20,
        Placements = 5
    },
    ["Akemy (Fallen Angel)"] = {
        Damage = Calculate(19500, 110),
        SPA = 12,
        Range = 32,
        Placements = 3
    },
    ["Prime Force (Peace)"] = {
        Damage = Calculate(7349, 110),
        SPA = 9,
        Range = 25,
        Placements = 4
    },
    ["Riony (Devil Princess))"] = {
        Damage = Calculate(12510, 110),
        SPA = 6,
        Range = 32,
        Placements = 3
    },
    ["Bubblegum (Ultimate)"] = {
        Damage = Calculate(23400, 110),
        SPA = 8,
        Range = 33,
        Placements = 3
    },
    ["Carrot (Ultra)"] = {
        Damage = Calculate(21600, 110),
        SPA = 9,
        Range = 35,
        Placements = 4
    },
    ["Vego (Mage II)"] = {
        Damage = Calculate(42000, 110),
        SPA = 11,
        Range = 30,
        Placements = 3
    },
    ["Sea God (Tyrant of the Seas)"] = {
        Damage = Calculate(7349, 110),
        SPA = 9,
        Range = 25,
        Placements = 3
    },
    ["Cream (Void)"] = {
        Damage = Calculate(32594.2, 110),
        SPA = 8.5,
        Range = 35,
        Placements = 3
    },
    ["Umbra (Nuclear)"] = {
        Damage = Calculate(35000, 110),
        SPA = 10,
        Range = 35,
        Placements = 3
    },
    ["Black Dog (HellHound)"] = {
        Damage = Calculate(39200, 110),
        SPA = 10,
        Range = 35,
        Placements = 3
    },
    ["Brawler (Soul)"] = {
        Damage = Calculate(6750, 110),
        SPA = 5,
        Range = 33,
        Placements = 4
    },
    ["InHuman (Nullifier)"] = {
        Damage = Calculate(27000, 110),
        SPA = 11,
        Range = 25,
        Placements = 3
    },
    ["Player (Argus)"] = {
        Damage = Calculate(15000, 110),
        SPA = 8,
        Range = 28,
        Placements = 4
    },
    ["Psychic Princess(evo)"] = {
        Damage = Calculate(13332, 110),
        SPA = 5.9,
        Range = 36.9,
        Placements = 4
    },
    ["Demonshade (Hiei)"] = {
        Damage = Calculate(3000, 110),
        SPA = 5,
        Range = 30,
        Placements = 5
    },
    ["Dracula (Unholy King)"] = {
        Damage = Calculate(42000, 110),
        SPA = 9,
        Range = 33,
        Placements = 3
    },
    ["Scarlet Slayer (Cursed Frost)"] = {
        Damage = Calculate(40656, 110),
        SPA = 12,
        Range = 33,
        Placements = 3
    },
    ["Shrimp (White Terror)"] = {
        Damage = Calculate(16500, 110),
        SPA = 8,
        Range = 35,
        Placements = 4
    },
    ["Spirit Sniper (Prodigy)"] = {
        Damage = Calculate(13000, 110),
        SPA = 8,
        Range = 45,
        Placements = 4
    },
    ["Fiend Girl (Butterfly)"] = {
        Damage = Calculate(18000, 110),
        SPA = 7,
        Range = 35,
        Placements = 4
    },
    ["Gas (Toxic)"] = {
        Damage = Calculate(10800, 110),
        SPA = 11,
        Range = 30,
        Placements = 4,
        Effect = {  -- Добавляем эффект для Ghost-kun (Bound)
            Type = "Poison",  -- Тип эффекта (огонь)
            DamagePerTick = 3.00,  -- 50% от урона за тик
            Ticks = 56,  -- Количество тиков (4 тика)
        }
    },
    ["Gravity Mage (Void)"] = {
        Damage = Calculate(20250, 110),
        SPA = 9,
        Range = 40,
        Placements = 4
    },
    ["Hammerhead (Shark Empress)"] = {
        Damage = Calculate(13000, 110),
        SPA = 7,
        Range = 36,
        Placements = 4
    },
    ["Takamu (Reborn)"] = {
        Damage = Calculate(11340, 110),
        SPA = 6.5,
        Range = 31,
        Placements = 4
    },
    ["Tiger (Moonlight Beast)"] = {
        Damage = Calculate(18735, 110),
        SPA = 6,
        Range = 28,
        Placements = 4,
        Effect = {  -- Добавляем эффект для Ghost-kun (Bound)
            Type = "Bleed",  -- Тип эффекта (огонь)
            DamagePerTick = 1.25,  -- 50% от урона за тик
            Ticks = 3,  -- Количество тиков (4 тика)
        }
    },
    ["Toad Sensei (Toad Sage)"] = {
        Damage = Calculate(15600, 110),
        SPA = 8,
        Range = 33,
        Placements = 4
    },
    ["Dark Mage (Fallen Star)"] = {
        Damage = Calculate(49500, 110),
        SPA = 13,
        Range = 35,
        Placements = 3
    },
    ["Elf Mage (Aura)"] = {
        Damage = Calculate(17550, 110),
        SPA = 5.5,
        Range = 48,
        Placements = 4
    },
    ["Ghost-kun (Bound)"] = {
        Damage = Calculate(18531, 110),
        SPA = 12,
        Range = 37.5,
        Placements = 3,
        Effect = {  -- Добавляем эффект для Ghost-kun (Bound)
            Type = "Fire",  -- Тип эффекта (огонь)
            DamagePerTick = 0.50,  -- 50% от урона за тик
            Ticks = 4,  -- Количество тиков (4 тика)
        }
    },
    ["Supreme Being (Sovereign)"] = {
        Damage = Calculate(37500, 110),
        SPA = 10,
        Range = 40,
        Placements = 1
    },
    ["Bodybuilder (Muscles)"] = {
        Damage = Calculate(9100, 110),
        SPA = 6.5,
        Range = 31,
        Placements = 4
    },
    ["Saka (Cyanblade)"] = {
        Damage = Calculate(9450, 110),
        SPA = 5,
        Range = 24,
        Placements = 4,
        Effect = {  -- Добавляем эффект для Ghost-kun (Bound)
            Type = "Bleed",  -- Тип эффекта (огонь)
            DamagePerTick = 1.40,  -- 50% от урона за тик
            Ticks = 4  -- Количество тиков (4 тика)
    }
},
    ["Gunslinger (Cross)"] = {
        Damage = Calculate(7700, 110),
        SPA = 10,
        Range = 36,
        Placements = 4
    },
    ["Tango (Flash God)"] = {
        Damage = Calculate(20655, 110),
        SPA = 12,
        Range = 25,
        Placements = 3
    },
    ["Catgirl (Hell-Cat)"] = {
        Damage = Calculate(10400, 110),
        SPA = 9,
        Range = 27,
        Placements = 3
    },
    ["Dragon Knight (Gauntlet)"] = {
        Damage = Calculate(16800, 110),
        SPA = 9,
        Range = 55,
        Placements = 3
    },
    ["Eccentric Researcher (Captain)"] = {
        Damage = Calculate(5915, 110),
        SPA = 6,
        Range = 30,
        Placements = 5,
        Effect = {  -- Добавляем эффект для Ghost-kun (Bound)
            Type = "Bleed",  -- Тип эффекта (огонь)
            DamagePerTick = 1.25,  -- 50% от урона за тик
            Ticks = 3,  -- Количество тиков (4 тика)
        }
    },
    ["Sepsis (Moon)"] = {
        Damage = Calculate(13775, 110),
        SPA = 8,
        Range = 35,
        Placements = 4
    },
    ["Berserker (Rage)"] = {
        Damage = Calculate(35625, 110),
        SPA = 13,
        Range = 28,
        Placements = 3,
        Effect = {  -- Добавляем эффект для Ghost-kun (Bound)
            Type = "Bleed",  -- Тип эффекта (огонь)
            DamagePerTick = 1.25,  -- 50% от урона за тик
            Ticks = 4,  -- Количество тиков (4 тика)
        }
    },
    ["Somber (Buzzsaw)"] = {
        Damage = Calculate(32305, 110),
        SPA = 14,
        Range = 70,
        Placements = 4,
        Effect = {  -- Добавляем эффект для Ghost-kun (Bound)
            Type = "Bleed",  -- Тип эффекта (огонь)
            DamagePerTick = 1.35,  -- 50% от урона за тик
            Ticks = 6,  -- Количество тиков (4 тика)
        }
    },
    ["Golden Tyrant (Emperor)"] = {
        Damage = Calculate(32500, 110),
        SPA = 14,
        Range = 37,
        Placements = 3
    },
    ["Stringy (Awakened)"] = {
        Damage = Calculate(31500, 110),
        SPA = 8,
        Range = 38,
        Placements = 3
    },
    ["Gazu (Maximum)"] = {
        Damage = Calculate(5320, 110),
        SPA = 7.5,
        Range = 30,
        Placements = 4
    },
    ["Golden King (Lord of Heroes)"] = {
        Damage = Calculate(49000, 110),
        SPA = 12,
        Range = 35,
        Placements = 3
    },
    ["Ice Queen (Empire's Strongest)"] = {
        Damage = Calculate(21775, 110),
        SPA = 20,
        Range = 32,
        Placements = 3
    },
    ["Jelly (Heaven)"] = {
        Damage = Calculate(5525, 110),
        SPA = 9,
        Range = 27.5,
        Placements = 4
    },
    ["Fiery Commander (Hellfire)"] = {
        Damage = Calculate(10500, 110),
        SPA = 13,
        Range = 35,
        Placements = 3,
        Effect = {  -- Добавляем эффект для Ghost-kun (Bound)
            Type = "Fire",  -- Тип эффекта (огонь)
            DamagePerTick = 0.30,  -- 50% от урона за тик
            Ticks = 5,  -- Количество тиков (4 тика)
        }
    },
    ["Skeleton Knight (King)"] = {
        Damage = Calculate(30800, 110),
        SPA = 6.5,
        Range = 41,
        Placements = 2
    },
    ["Shizo (Flicker)"] = {
        Damage = Calculate(14000, 110),
        SPA = 8,
        Range = 35,
        Placements = 3
    },
    ["Mangaka (Artist)"] = {
        Damage = Calculate(10625, 110),
        SPA = 6,
        Range = 29,
        Placements = 4
    },
    ["Pirate King (Final)"] = {
        Damage = Calculate(24500, 110),
        SPA = 5.5,
        Range = 35,
        Placements = 3
    },
    ["Fused Hero"] = {
        Damage = Calculate(70000, 110),
        SPA = 6,
        Range = 42,
        Placements = 3
    },
    ["Captain (God)"] = {
        Damage = Calculate(45000, 110),
        SPA = 5,
        Range = 10,
        Placements = 3
    },
    ["Saki (Cyanblade)"] = {
        Damage = Calculate(8436, 110),
        SPA = 4.5,
        Range = 25,
        Placements = 5
    },
    ["Priest (New Moon)"] = {
        Damage = Calculate(6250, 110),
        SPA = 5,
        Range = 32,
        Placements = 3
    },
    ["Red Scar (Conqueror)"] = {
        Damage = Calculate(1500, 110),
        SPA = 5,
        Range = 22,
        Placements = 3
    },
    ["Millie (Holy)"] = {
        Damage = Calculate(21000, 110),
        SPA = 9,
        Range = 35,
        Placements = 3
    },
    ["Illusionist (Betrayal)"] = {
        Damage = Calculate(2600, 110),
        SPA = 6.5,
        Range = 22,
        Placements = 3
    },
    ["Paragon (Devil)"] = {
        Damage = Calculate(20800, 110),
        SPA = 7,
        Range = 35,
        Placements = 3
    },
    ["Experiment X (SUPER PERFECT)"] = {
        Damage = Calculate(5070, 110),
        SPA = 6,
        Range = 34,
        Placements = 4
    },
    ["Blade Beast (Hybrid)"] = {
        Damage = Calculate(7020, 110),
        SPA = 8.5,
        Range = 25,
        Placements = 4,
        Effect = {  -- Добавляем эффект для Ghost-kun (Bound)
            Type = "Bleed",  -- Тип эффекта (огонь)
            DamagePerTick = 1.50,  -- 50% от урона за тик
            Ticks = 4,  -- Количество тиков (4 тика)
        }
    },
    ["Connor (Wizard King)"] = {
        Damage = Calculate(25200, 110),
        SPA = 10,
        Range = 35,
        Placements = 3
    },
    ["Elize (Valkyrie)"] = {
        Damage = Calculate(5525, 110),
        SPA = 9,
        Range = 33,
        Placements = 4
    },
    ["Paradox (Divine Sight)"] = {
        Damage = Calculate(5250, 110),
        SPA = 6,
        Range = 40,
        Placements = 3
    },
    ["Death Ninja (Immortal Butcher)"] = {
        Damage = Calculate(10500, 110),
        SPA = 6.5,
        Range = 30,
        Placements = 3,
        Effect = {  -- Добавляем эффект для Ghost-kun (Bound)
            Type = "Bleed",  -- Тип эффекта (огонь)
            DamagePerTick = 1.30,  -- 50% от урона за тик
            Ticks = 3,  -- Количество тиков (4 тика)
        }
    },
    ["Blade Beast"] = {
        Damage = Calculate(4000, 110),
        SPA = 7,
        Range = 26,
        Placements = 3,
        Effect = {  -- Добавляем эффект для Ghost-kun (Bound)
            Type = "Bleed",  -- Тип эффекта (огонь)
            DamagePerTick = 1.30,  -- 50% от урона за тик
            Ticks = 3,  -- Количество тиков (4 тика)
        }
    },
    ["Reliable Student (Echoes)"] = {
        Damage = Calculate(11250, 110),
        SPA = 7,
        Range = 30,
        Placements = 4
    },
    ["Kyko (Crimson Spear)"] = {
        Damage = Calculate(18200, 110),
        SPA = 8,
        Range = 40,
        Placements = 4
    },
    ["Joykid (Gear IV)"] = {
        Damage = Calculate(17550, 110),
        SPA = 7,
        Range = 35,
        Placements = 4
    },
    ["Magic Girl (Salvation)"] = {
        Damage = Calculate(9620, 110),
        SPA = 6.5,
        Range = 45,
        Placements = 4
    },
    ["Illusionist (Transcended) "] = {
        Damage = Calculate(75000, 110),
        SPA = 7,
        Range = 40,
        Placements = 1
    },
    ["Spider (Immolation)"] = {
        Damage = Calculate(21261, 110),
        SPA = 11.5,
        Range = 32.5,
        Placements = 3,
        Effect = {  -- Добавляем эффект для Ghost-kun (Bound)
            Type = "Fire",  -- Тип эффекта (огонь)
            DamagePerTick = 0.07,  -- 50% от урона за тик
            Ticks = 5,  -- Количество тиков (4 тика)
        }
    },
    ["Switchblade (Deception)"] = {
        Damage = Calculate(58500, 110),
        SPA = 11,
        Range = 45,
        Placements = 3
    },
    ["Legendary Assassin (Prime)"] = {
        Damage = Calculate(37500, 110),
        SPA = 8.5,
        Range = 37,
        Placements = 3
    },
    ["Legendary Assassin (MAX(200%))"] = {
        Damage = Calculate(112500, 110),
        SPA = 8.5,
        Range = 37,
        Placements = 3
    },
    ["Legendary Assassin (MAX(200%))"] = {
        Damage = Calculate(14300, 110),
        SPA = 13,
        Range = 43,
        Placements = 3
    },
    ["Killstreak (Speedrun)"] = {
        Damage = Calculate(25000, 110),
        SPA = 8,
        Range = 40,
        Placements = 4
    },
    ["Android AAA"] = {
        Damage = Calculate(6000, 110),
        SPA = 9,
        Range = 35,
        Placements = 4
    },
    ["Siren (Harpy)"] = {
        Damage = Calculate(16380, 110),
        SPA = 7,
        Range = 33,
        Placements = 4
    },
    ["Iceclaw (Azure Fang)"] = {
        Damage = Calculate(37500, 110),
        SPA = 9,
        Range = 34,
        Placements = 4
    },
    ["Psychic Princess (Evo)"] = {
        Damage = Calculate(13332, 110),
        SPA = 5.9,
        Range = 36.9,
        Placements = 4
    },
    ["Silver Slayer (Hunter)"] = {
        Damage = Calculate(26159, 110),
        SPA = 7.3,
        Range = 32.2,
        Placements = 4
    },
    
    skrilya = {
        Damage = Calculate(1315, 110),
        SPA = 1315,
        Range = 1315,
        Placements = 1315
    }
    -- Добавьте все остальные юниты аналогично...
}

-- Данные Traits
local Traits = {
    Traitless = {},
    Superior1 = {
        Damage = 1.10 
    },
    Superior2 = {
        Damage = 1.125
    },
    Superior3 = {
        Damage = 1.15
    },
    Nimble1 = {
        SPA = 0.95
    },
    Nimble2 = {
        SPA = 0.925
    },
    Nimble3 = {
        SPA = 0.88
    },
    Range1 = {
        Range = 1.10
    },
    Range2 = {
        Range = 1.125
    },
    Range3 = {
        Range = 1.15 
    },
    Sniper = {
        Range = 1.20
    },
    Godspeed = {
        SPA = 0.80
    },
    Reaper = {
        Damage = 1.15
    },
    Celestial = {
        Damage = 1.10,
        Range = 1.10
    },
    Divine = {
        Damage = 1.20,
        SPA = 0.9,
        Range = 1.20
    },
    Golden = {
        Damage = 1.30
    },
    Unique = {
        Damage = 4,
        SPA = 0.90,
        Range = 1.10,
        Placements = 1
    } 
}

-- Функция для применения Bleed
local function applyBleed(Stats, Effect)
    local baseBleedDamage = Stats["Damage"] * Effect["DamagePerTick"]
    
    -- Устанавливаем значение по умолчанию для DamagePerTickBuff (если оно не задано)
    local bleedDamageWithBuff = baseBleedDamage * (Effect["DamagePerTickBuff"] or 0)
    
    return bleedDamageWithBuff / Stats["SPA"]  -- Урон от Bleed за секунду
end

-- Функция для применения Poison
local function applyPoison(Stats, Effect)
    local basePoisonDamage = Stats["Damage"] * Effect["DamagePerTick"]
    return basePoisonDamage / Stats["SPA"]  -- Урон от Poison за секунду
end

-- Функция для применения Decay
local function applyDecay(Stats, Effect)
    local decayDamage = Stats["Damage"] * 0.20  -- Урон от Decay — 20% от Damage
    return decayDamage / Stats["SPA"]  -- Урон от Decay за секунду
end

-- Функция для применения Fire (огонь)
local function applyFire(Stats, Effect)
    local fireDamagePerTick = Stats["Damage"] * Effect["DamagePerTick"]
    local totalFireDamage = fireDamagePerTick * Effect["Ticks"]  -- Урон за все тики
    return totalFireDamage / Stats["SPA"]  -- Урон от Fire за секунду
end

-- Основная функция для расчета DPS и GDPS
local function SingleHandler(Name, Trait, Stats, Data, wave)
    local Placements = Stats["Placements"]
    local Effect = Stats["Effect"]
    local Damage = Stats["Damage"]
    local SPA = Stats["SPA"]
    local Range = Stats["Range"]
    local Critical = 1.5
    local Rate = 0

    -- Инициализация урона от DoT эффектов
    local bleedDPS = 0
    local poisonDPS = 0
    local decayDPS = 0

    -- Применяем эффекты, если они присутствуют
    if Effect then
        if Effect["Type"] == "Bleed" then
            bleedDPS = applyBleed(Stats, Effect)
        elseif Effect["Type"] == "Poison" then
            poisonDPS = applyPoison(Stats, Effect)
        elseif Effect["Type"] == "Decay" then
            decayDPS = applyDecay(Stats, Effect)
        end
    end

    -- Обработка данных (множители урона, SPA и т.д.)
    for i, v in next, Data do
        if i == "Rate" then Rate = Rate + v
        elseif i == "Critical" then Critical = Critical * v
        elseif i == "SPA" then SPA = SPA * v
        elseif i == "Damage" then Damage = Damage * v
        elseif i == "Placements" then Placements = v
        elseif i == "Range" then Range = Range * v
        end
    end

    -- Рассчитываем итоговый урон с учетом всех эффектов
    local CriticalDamage = Damage * (1 + Rate * (Critical - 1))
    local DPS = CriticalDamage / SPA

    -- Добавляем DoT эффекты (например, Bleed, Poison, Decay)
    DPS = DPS + bleedDPS + poisonDPS + decayDPS

    -- Рассчитываем GDPS
    local GDPS = DPS * Placements

    -- Возвращаем результат расчета DPS и GDPS для юнита
    return {
        Name = Name,
        Trait = Trait,
        DPS = DPS,
        GDPS = GDPS,  -- Добавляем GDPS
        Damage = Damage,
        SPA = SPA,
        Range = Range,
        Placements = Placements
    }
end

-- Применение всех Traits для одного трейта
local function SingleTrait(Name, Stats)
    local result = {}
    for Trait, Data in next, Traits do  
        local line = SingleHandler(Name, Trait, Stats, Data)
        table.insert(result, line)
    end 
    return result
end 

-- Функция DoubleTrait V2
local function DoubleTrait(Name, Stats)
    local result = {}
    local traitList = {}  -- Список для всех возможных комбинаций трейтов
    local traits = {}  -- Список всех трейтов для удобного доступа

    -- Собираем все трейты в список
    for Trait, _ in pairs(Traits) do
        table.insert(traits, Trait)
    end

    -- Перебираем трейты, исключая дубликаты
    for i = 1, #traits do
        for j = i, #traits do
            local Trait1 = traits[i]
            local Trait2 = traits[j]

            -- Создаем комбинированные данные
            local combinedData = {}
            for key, value in pairs(Traits[Trait1]) do
                combinedData[key] = value
            end
            for key, value in pairs(Traits[Trait2]) do
                if combinedData[key] then
                    combinedData[key] = combinedData[key] * value  -- Умножаем значения для комбинированных трейтов
                else
                    combinedData[key] = value
                end
            end

            -- Добавляем комбинацию в список
            table.insert(traitList, {Trait1, Trait2, combinedData})
        end
    end

    -- Вычисляем DPS и GDPS для каждой комбинации
    for _, traits in ipairs(traitList) do
        local line = SingleHandler(Name, traits[1] .. "+" .. traits[2], Stats, traits[3])
        table.insert(result, line)
    end

    return result
end

-- Функция для сортировки по GDPS
local function sortByGDPS(a, b)
    return a.GDPS > b.GDPS  -- Сортируем по убыванию GDPS
end

-- Основная функция для отправки данных на вебхук
local function OutputResultsToWebhook(webhookUrl)
    local resultsTrait = {}
    local resultsDoubleTrait = {}
    
    -- Для каждого юнита обрабатываем его Traits
    for Name, Stats in next, Units do
        local unitResultsTrait = SingleTrait(Name, Stats)
        for _, result in ipairs(unitResultsTrait) do
            table.insert(resultsTrait, result)
        end

        local unitResultsDoubleTrait = DoubleTrait(Name, Stats)
        for _, result in ipairs(unitResultsDoubleTrait) do
            table.insert(resultsDoubleTrait, result)
        end
    end

    -- Сортируем результаты по GDPS
    table.sort(resultsTrait, sortByGDPS)
    table.sort(resultsDoubleTrait, sortByGDPS)

    -- Генерация текста для первого файла (Trait)
    local fileContentTrait = ""
    local counter = 1
    for _, result in ipairs(resultsTrait) do
        fileContentTrait = fileContentTrait .. string.format(
            "%d. %s Trait: %s | GDPS: %s | DPS: %s | Damage: %s | SPA: %s | Range: %s | Placements: %s\n",
            counter, result.Name, result.Trait, format(result.GDPS), format(result.DPS), format(result.Damage), format(result.SPA), format(result.Range), result.Placements
        )
        counter = counter + 1
    end

    -- Генерация текста для второго файла (Double Trait)
    local fileContentDoubleTrait = ""
    counter = 1
    for _, result in ipairs(resultsDoubleTrait) do
        fileContentDoubleTrait = fileContentDoubleTrait .. string.format(
            "%d. %s Trait Combination: %s | GDPS: %s | DPS: %s | Damage: %s | SPA: %s | Range: %s | Placements: %s\n",
            counter, result.Name, result.Trait, format(result.GDPS), format(result.DPS), format(result.Damage), format(result.SPA), format(result.Range), result.Placements
        )
        counter = counter + 1
    end

    -- Отправляем оба файла с результатами
    sendWebhookWithFile(fileContentTrait, "DPS_single_trait.txt")
    sendWebhookWithFile(fileContentDoubleTrait, "DPS_double_trait.txt")
end

-- Запуск отправки результатов на вебхук
OutputResultsToWebhook(webhook)
