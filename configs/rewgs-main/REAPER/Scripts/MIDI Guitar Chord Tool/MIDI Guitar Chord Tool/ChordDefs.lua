-- Guitar Chord Definitions
--[[
    Nice guitar chord reference:
    https://www.theguitarlesson.com/free-guitar-chords/
--]]

------------------------------------------------------------------------------------------------------------------------local function PairsByKeys (t, f)
    local a = {}
    for n in pairs(t) do table.insert(a, n) end
    table.sort(a, f)
    local i = 0      -- iterator variable
    local iter = function ()   -- iterator function
        i = i + 1
        if a[i] == nil then return nil
        else return a[i], t[a[i]]
        end
    end
    return iter
end
------------------------------------------------------------------------------------------------------------------------

return {
-- Channel (0 = Channel 1), OpenNote (60 = Middle C)
    StringDefs = { -- settings for each guitar string
        { Channel = 0,  OpenNote = 64, }, -- string 1
        { Channel = 1,  OpenNote = 59, }, -- string 2
        { Channel = 2,  OpenNote = 55, }, -- string 3
        { Channel = 3,  OpenNote = 50, }, -- string 4
        { Channel = 4,  OpenNote = 45, }, -- string 5
        { Channel = 5,  OpenNote = 40, }, -- string 6
    },

------------------------------------------------------------------------------------------------------------------------
-- Chord form roots

    ChordFormRoots = { -- string and fret of the root note for each chord form
        E     = { 6, 0, },
        A     = { 5, 0, },
        D     = { 4, 0, },
        G     = { 6, 3, },
        C     = { 5, 3, },
        ['1'] = { 1, 0, },
        ['2'] = { 2, 0, },
        ['3'] = { 3, 0, },
        ['4'] = { 4, 0, },
    },

------------------------------------------------------------------------------------------------------------------------
-- Chord families (for creating the buttons)
    ChordFamilies = {        {
--            Name = ' Major',
            Name = 'Major',
            {
                'Maj',
                'Maj6',
                'Maj6/9',
                'MajAdd9',
                'Maj7',
                'Maj9',
                'Maj9#11',
                'Maj13',
            },
        },

        {
--            Name = ' Minor',
            Name = 'Minor',
            {
                'Min',
                'Min6',
                'Min6/9',
                'MinAdd9',
                'MinMaj7',
                'Min7',
                'Min7b5',
                'Min7#5',
                'Min9',
                'Min7b9',
                'Min11',
                'Min13',
            },
        },

        {
--            Name = '     Dominant',
            Name = 'Dominant',
            {
                '7',
                '7Sus4',
                '7b5',
                '7#5',
                '7b9',
                '7#9',
            },
            {
                '9',
                '9b5',
                '9#5',
                '9#11',
                '11',
                '13',
            },
        },

        {
--            Name = ' Other',
            Name = 'Other',
            {
                'Aug',
                'Dim',
                'Dim7',
                'Sus2',
                'Sus4',
            },
        },

        {
            Name = 'Inversions',
            {
                'Maj',
                'Min',
                'Aug',
                'Dim',
            },
            {
                'Maj6',
                'Min6',
                'Maj7',
                'Min7',
                'MinMaj7',
                '7',
                'Dim7',
            },
        },

    },

------------------------------------------------------------------------------------------------------------------------
-- Chord string/fret definitions    ChordFormDefs = {
--[[            New = {

                E = {
                    { String = 1,   Fret =  0,  Optional = false, }, --
                    { String = 2,   Fret =  0,  Optional = false, }, --
                    { String = 3,   Fret =  0,  Optional = false, }, --
                    { String = 4,   Fret =  0,  Optional = false, }, --
                    { String = 5,   Fret =  0,  Optional = false, }, --
                    { String = 6,   Fret =  0,  Optional = false, }, -- R
                },

                A = {
                    { String = 1,   Fret =  0,  Optional = false, }, --
                    { String = 2,   Fret =  0,  Optional = false, }, --
                    { String = 3,   Fret =  0,  Optional = false, }, --
                    { String = 4,   Fret =  0,  Optional = false, }, --
                    { String = 5,   Fret =  0,  Optional = false, }, -- R
                    { String = 6,   Fret =  0,  Optional = true,  }, --
                },

                D = {
                    { String = 1,   Fret =  0,  Optional = false, }, --
                    { String = 2,   Fret =  0,  Optional = false, }, --
                    { String = 3,   Fret =  0,  Optional = false, }, --
                    { String = 4,   Fret =  0,  Optional = false, }, -- R
                    { String = 5,   Fret =  0,  Optional = true,  }, --
                    { String = 6,   Fret =  0,  Optional = true,  }, --
                },

                G = {
                    { String = 1,   Fret =  3,  Optional = false, }, --
                    { String = 2,   Fret =  3,  Optional = false, }, --
                    { String = 3,   Fret =  3,  Optional = false, }, --
                    { String = 4,   Fret =  3,  Optional = false, }, --
                    { String = 5,   Fret =  3,  Optional = false, }, --
                    { String = 6,   Fret =  3,  Optional = false, }, -- R
                },

                C = {
                    { String = 1,   Fret =  3,  Optional = false, }, --
                    { String = 2,   Fret =  3,  Optional = false, }, --
                    { String = 3,   Fret =  3,  Optional = false, }, --
                    { String = 4,   Fret =  3,  Optional = false, }, --
                    { String = 5,   Fret =  3,  Optional = false, }, -- R
                    { String = 6,   Fret =  3,  Optional = true,  }, --
                },

            },
--]]
------------------------------------------------------------------------------------------------------------------------
-- Major family        Major = {

            Maj = {

                E = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- R
                    { String = 2,   Fret =  0,  Optional = false, }, -- 5
                    { String = 3,   Fret =  1,  Optional = false, }, -- 3
                    { String = 4,   Fret =  2,  Optional = false, }, -- R
                    { String = 5,   Fret =  2,  Optional = false, }, -- 5
                    { String = 6,   Fret =  0,  Optional = false, }, -- R
                },

                A = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- 5
                    { String = 2,   Fret =  2,  Optional = false, }, -- 3
                    { String = 3,   Fret =  2,  Optional = false, }, -- R
                    { String = 4,   Fret =  2,  Optional = false, }, -- 5
                    { String = 5,   Fret =  0,  Optional = false, }, -- R
                    { String = 6,   Fret =  0,  Optional = true,  }, -- 5
                },

                D = {
                    { String = 1,   Fret =  2,  Optional = false, }, -- 3
                    { String = 2,   Fret =  3,  Optional = false, }, -- R
                    { String = 3,   Fret =  2,  Optional = false, }, -- 5
                    { String = 4,   Fret =  0,  Optional = false, }, -- R
                    { String = 5,   Fret =  0,  Optional = true,  }, -- 5
                    { String = 6,   Fret =  2,  Optional = true,  }, -- 3
                },

                G = {
                    { String = 1,   Fret =  3,  Optional = false, }, -- R
                    { String = 2,   Fret =  0,  Optional = false, }, -- 3  (move up to fret 3 for the 5th if desired)
                    { String = 3,   Fret =  0,  Optional = false, }, -- R
                    { String = 4,   Fret =  0,  Optional = false, }, -- 5
                    { String = 5,   Fret =  2,  Optional = false, }, -- 3
                    { String = 6,   Fret =  3,  Optional = false, }, -- R
                },

                C = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- 3
                    { String = 2,   Fret =  1,  Optional = false, }, -- R
                    { String = 3,   Fret =  0,  Optional = false, }, -- 5
                    { String = 4,   Fret =  2,  Optional = false, }, -- 3
                    { String = 5,   Fret =  3,  Optional = false, }, -- R
                    { String = 6,   Fret =  3,  Optional = true,  }, -- 5
                },

            },
            Maj6 = {
                E = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- R
                    { String = 2,   Fret =  2,  Optional = false, }, -- 6
                    { String = 3,   Fret =  1,  Optional = false, }, -- 3
                    { String = 4,   Fret =  2,  Optional = false, }, -- R
                    { String = 5,   Fret =  2,  Optional = false, }, -- 5
                    { String = 6,   Fret =  0,  Optional = false, }, -- R
                },

                A = {
                    { String = 1,   Fret =  2,  Optional = false, }, -- 6
                    { String = 2,   Fret =  2,  Optional = false, }, -- 3
                    { String = 3,   Fret =  2,  Optional = false, }, -- R
                    { String = 4,   Fret =  2,  Optional = false, }, -- 5
                    { String = 5,   Fret =  0,  Optional = false, }, -- R
                    { String = 6,   Fret =  0,  Optional = true,  }, -- 5
                },

                D = {
                    { String = 1,   Fret =  2,  Optional = false, }, -- 3
                    { String = 2,   Fret =  0,  Optional = false, }, -- 6
                    { String = 3,   Fret =  2,  Optional = false, }, -- 5
                    { String = 4,   Fret =  0,  Optional = false, }, -- R
                    { String = 5,   Fret =  0,  Optional = true,  }, -- 5
                    { String = 6,   Fret =  2,  Optional = true,  }, -- 3
                },

                G = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- 6
                    { String = 2,   Fret =  0,  Optional = false, }, -- 3  (move up to fret 3 for the 5th if desired)
                    { String = 3,   Fret =  0,  Optional = false, }, -- R
                    { String = 4,   Fret =  0,  Optional = false, }, -- 5
                    { String = 5,   Fret =  2,  Optional = false, }, -- 3
                    { String = 6,   Fret =  3,  Optional = false, }, -- R
                },

                C = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- 3
                    { String = 2,   Fret =  1,  Optional = false, }, -- R
                    { String = 3,   Fret =  2,  Optional = false, }, -- 6
                    { String = 4,   Fret =  2,  Optional = false, }, -- 3
                    { String = 5,   Fret =  3,  Optional = false, }, -- R
                    { String = 6,   Fret =  3,  Optional = true,  }, -- 5
                },
            },
            ["Maj6/9"] = {

                E = {
                    { String = 1,   Fret =  2,  Optional = false, }, -- 9
                    { String = 2,   Fret =  2,  Optional = false, }, -- 6
                    { String = 3,   Fret =  1,  Optional = false, }, -- 3
                    { String = 4,   Fret =  2,  Optional = false, }, -- R
                    { String = 5,   Fret =  2,  Optional = false, }, -- 5
                    { String = 6,   Fret =  0,  Optional = false, }, -- R
                },

                A = {
                    { String = 1,   Fret =  2,  Optional = false, }, -- 6
                    { String = 2,   Fret =  2,  Optional = false, }, -- 3
                    { String = 3,   Fret =  4,  Optional = false, }, -- 9
                    { String = 4,   Fret =  2,  Optional = false, }, -- 5
                    { String = 5,   Fret =  0,  Optional = false, }, -- R
                    { String = 6,   Fret =  0,  Optional = true,  }, -- 5
                },

                D = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- 9
                    { String = 2,   Fret =  0,  Optional = false, }, -- 6
                    { String = 3,   Fret = -1,  Optional = false, }, -- 3
                    { String = 4,   Fret =  0,  Optional = false, }, -- R
                    { String = 5,   Fret =  0,  Optional = true,  }, -- 5
                    { String = 6,   Fret =  2,  Optional = true,  }, -- 3
                },

                G = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- 6
                    { String = 2,   Fret =  0,  Optional = false, }, -- 3  (move up to fret 3 for the 5th if desired)
                    { String = 3,   Fret =  2,  Optional = false, }, -- 9
                    { String = 4,   Fret =  0,  Optional = false, }, -- 5
                    { String = 5,   Fret =  2,  Optional = false, }, -- 3
                    { String = 6,   Fret =  3,  Optional = false, }, -- R
                },

                C = {
                    { String = 1,   Fret =  3,  Optional = false, }, -- 5
                    { String = 2,   Fret =  3,  Optional = false, }, -- 9
                    { String = 3,   Fret =  2,  Optional = false, }, -- 6
                    { String = 4,   Fret =  2,  Optional = false, }, -- 3
                    { String = 5,   Fret =  3,  Optional = false, }, -- R
                    { String = 6,   Fret =  3,  Optional = true,  }, -- 5
                },

            },

            MajAdd9 = {

                E = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- R
                    { String = 2,   Fret =  0,  Optional = false, }, -- 5
                    { String = 3,   Fret =  1,  Optional = false, }, -- 3
                    { String = 4,   Fret =  4,  Optional = false, }, -- 9
                    { String = 5,   Fret =  2,  Optional = false, }, -- 5
                    { String = 6,   Fret =  0,  Optional = false, }, -- R
                },

                A = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- 5
                    { String = 2,   Fret =  2,  Optional = false, }, -- 3
                    { String = 3,   Fret =  4,  Optional = false, }, -- 9
                    { String = 4,   Fret =  2,  Optional = false, }, -- 5
                    { String = 5,   Fret =  0,  Optional = false, }, -- R
                    { String = 6,   Fret =  0,  Optional = true,  }, -- 5
                },

                D = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- 9
                    { String = 2,   Fret = -2,  Optional = false, }, -- 5
                    { String = 3,   Fret = -1,  Optional = false, }, -- 3
                    { String = 4,   Fret =  0,  Optional = false, }, -- R
                    { String = 5,   Fret =  0,  Optional = true,  }, -- 5
                    { String = 6,   Fret =  2,  Optional = true,  }, -- 3
                },

--[[ Alternate definition
                D = { -- Alternate definition
                    { String = 1,   Fret =  2,  Optional = false, }, -- 3
                    { String = 2,   Fret =  5,  Optional = false, }, -- 9
                    { String = 3,   Fret =  2,  Optional = false, }, -- 5
                    { String = 4,   Fret =  0,  Optional = false, }, -- R
                    { String = 5,   Fret =  0,  Optional = true,  }, -- 5
                    { String = 6,   Fret =  2,  Optional = true,  }, -- 3
                },
--]]
                G = {
                    { String = 1,   Fret =  3,  Optional = false, }, -- R
                    { String = 2,   Fret =  0,  Optional = false, }, -- 3
                    { String = 3,   Fret =  2,  Optional = false, }, -- 9
                    { String = 4,   Fret =  0,  Optional = false, }, -- 5
                    { String = 5,   Fret =  2,  Optional = false, }, -- 3
                    { String = 6,   Fret =  3,  Optional = false, }, -- R
                },

                C = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- 3
                    { String = 2,   Fret =  3,  Optional = false, }, -- 9
                    { String = 3,   Fret =  0,  Optional = false, }, -- 5
                    { String = 4,   Fret =  2,  Optional = false, }, -- 3
                    { String = 5,   Fret =  3,  Optional = false, }, -- R
                    { String = 6,   Fret =  3,  Optional = true,  }, -- 5
                },

            },

            Maj7 = {

                E = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- R
                    { String = 2,   Fret =  0,  Optional = false, }, -- 5
                    { String = 3,   Fret =  1,  Optional = false, }, -- 3
                    { String = 4,   Fret =  1,  Optional = false, }, -- 7
                    { String = 5,   Fret =  2,  Optional = false, }, -- 5
                    { String = 6,   Fret =  0,  Optional = false, }, -- R
                },

                A = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- 5
                    { String = 2,   Fret =  2,  Optional = false, }, -- 3
                    { String = 3,   Fret =  1,  Optional = false, }, -- 7
                    { String = 4,   Fret =  2,  Optional = false, }, -- 5
                    { String = 5,   Fret =  0,  Optional = false, }, -- R
                    { String = 6,   Fret =  0,  Optional = true,  }, -- 5
                },

                D = {
                    { String = 1,   Fret =  2,  Optional = false, }, -- 3
                    { String = 2,   Fret =  2,  Optional = false, }, -- 7
                    { String = 3,   Fret =  2,  Optional = false, }, -- 5
                    { String = 4,   Fret =  0,  Optional = false, }, -- R
                    { String = 5,   Fret =  0,  Optional = true,  }, -- 5
                    { String = 6,   Fret =  2,  Optional = true,  }, -- 3
                },

                G = {
                    { String = 1,   Fret =  2,  Optional = false, }, -- 7
                    { String = 2,   Fret =  0,  Optional = false, }, -- 3
                    { String = 3,   Fret =  0,  Optional = false, }, -- R
                    { String = 4,   Fret =  0,  Optional = false, }, -- 5
                    { String = 5,   Fret =  2,  Optional = false, }, -- 3
                    { String = 6,   Fret =  3,  Optional = false, }, -- R
                },

                C = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- 3
                    { String = 2,   Fret =  0,  Optional = false, }, -- 7
                    { String = 3,   Fret =  0,  Optional = false, }, -- 5
                    { String = 4,   Fret =  2,  Optional = false, }, -- 3
                    { String = 5,   Fret =  3,  Optional = false, }, -- R
                    { String = 6,   Fret =  3,  Optional = true,  }, -- 5
                },

            },

            Maj9 = {

                E = {
                    { String = 1,   Fret =  2,  Optional = false, }, -- 9
                    { String = 2,   Fret =  0,  Optional = false, }, -- 5
                    { String = 3,   Fret =  1,  Optional = false, }, -- 3
                    { String = 4,   Fret =  1,  Optional = false, }, -- 7
                    { String = 5,   Fret =  2,  Optional = false, }, -- 5
                    { String = 6,   Fret =  0,  Optional = false, }, -- R
                },
                A = { -- this has no 3rd, but I really don't see a way to fit it in there easily
                    { String = 1,   Fret =  0,  Optional = false, }, -- 5
                    { String = 2,   Fret =  0,  Optional = false, }, -- 9
                    { String = 3,   Fret =  1,  Optional = false, }, -- 7
                    { String = 4,   Fret =  2,  Optional = false, }, -- 5
                    { String = 5,   Fret =  0,  Optional = false, }, -- R
                    { String = 6,   Fret =  0,  Optional = true,  }, -- 5
                },

                D = { -- this has a third, but only in an optional position
                    { String = 1,   Fret =  0,  Optional = false, }, -- 9
                    { String = 2,   Fret =  2,  Optional = false, }, -- 7
                    { String = 3,   Fret =  2,  Optional = false, }, -- 5
                    { String = 4,   Fret =  0,  Optional = false, }, -- R
                    { String = 5,   Fret =  0,  Optional = true,  }, -- 5
                    { String = 6,   Fret =  2,  Optional = true,  }, -- 3
                },

                G = {
                    { String = 1,   Fret =  3,  Optional = false, }, -- R
                    { String = 2,   Fret =  3,  Optional = false, }, -- 5
                    { String = 3,   Fret =  2,  Optional = false, }, -- 9
                    { String = 4,   Fret =  4,  Optional = false, }, -- 7
                    { String = 5,   Fret =  2,  Optional = false, }, -- 3
                    { String = 6,   Fret =  3,  Optional = false, }, -- R
                },

                C = {
                    { String = 1,   Fret =  3,  Optional = false, }, -- 5
                    { String = 2,   Fret =  3,  Optional = false, }, -- 9
                    { String = 3,   Fret =  4,  Optional = false, }, -- 7
                    { String = 4,   Fret =  2,  Optional = false, }, -- 3
                    { String = 5,   Fret =  3,  Optional = false, }, -- R
                    { String = 6,   Fret =  3,  Optional = true,  }, -- 5
                },

            },

            ['Maj9#11'] = {

                E = {
                    { String = 1,   Fret =  2,  Optional = false, }, -- 9
                    { String = 2,   Fret =  4,  Optional = false, }, -- 7
                    { String = 3,   Fret =  3,  Optional = false, }, -- #11
                    { String = 4,   Fret =  2,  Optional = false, }, -- R
                    { String = 5,   Fret =  2,  Optional = false, }, -- 5
                    { String = 6,   Fret =  0,  Optional = false, }, -- R
                },

                A = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- 5
                    { String = 2,   Fret =  0,  Optional = false, }, -- 9
                    { String = 3,   Fret =  1,  Optional = false, }, -- 7
                    { String = 4,   Fret =  1,  Optional = false, }, -- #11
                    { String = 5,   Fret =  0,  Optional = false, }, -- R
                    { String = 6,   Fret =  0,  Optional = true,  }, -- 5
                },

                D = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- 9
                    { String = 2,   Fret =  2,  Optional = false, }, -- 7
                    { String = 3,   Fret =  1,  Optional = false, }, -- #11
                    { String = 4,   Fret =  0,  Optional = false, }, -- R
                    { String = 5,   Fret =  0,  Optional = true,  }, -- 5
                    { String = 6,   Fret =  2,  Optional = true,  }, -- 3
                },

                -- G = {
                    -- { String = 1,   Fret =  3,  Optional = false, }, --
                    -- { String = 2,   Fret =  3,  Optional = false, }, --
                    -- { String = 3,   Fret =  3,  Optional = false, }, --
                    -- { String = 4,   Fret =  3,  Optional = false, }, --
                    -- { String = 5,   Fret =  3,  Optional = false, }, --
                    -- { String = 6,   Fret =  3,  Optional = false, }, -- R
                -- },

                C = {
                    { String = 1,   Fret =  2,  Optional = false, }, -- #11
                    { String = 2,   Fret =  3,  Optional = false, }, -- 9
                    { String = 3,   Fret =  4,  Optional = false, }, -- 7
                    { String = 4,   Fret =  2,  Optional = false, }, -- 3
                    { String = 5,   Fret =  3,  Optional = false, }, -- R
                    { String = 6,   Fret =  3,  Optional = true,  }, -- 5
                },

            },
            Maj13 = {

                E = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- R
                    { String = 2,   Fret =  2,  Optional = false, }, -- 13
                    { String = 3,   Fret =  1,  Optional = false, }, -- 3
                    { String = 4,   Fret =  1,  Optional = false, }, -- 7
                    { String = 5,   Fret =  2,  Optional = false, }, -- 5
                    { String = 6,   Fret =  0,  Optional = false, }, -- R
                },

                A = {
                    { String = 1,   Fret =  2,  Optional = false, }, -- 13
                    { String = 2,   Fret =  0,  Optional = false, }, -- 9
                    { String = 3,   Fret =  1,  Optional = false, }, -- 7
                    { String = 4,   Fret = -1,  Optional = false, }, -- 3
                    { String = 5,   Fret =  0,  Optional = false, }, -- R
                    { String = 6,   Fret =  0,  Optional = true,  }, -- 5
                },

                D = {
                    -- { String = 1,   Fret =  0,  Optional = false, }, --
                    -- { String = 2,   Fret =  0,  Optional = false, }, --
                    -- { String = 3,   Fret =  0,  Optional = false, }, --
                    -- { String = 4,   Fret =  0,  Optional = false, }, -- R
                    -- { String = 5,   Fret =  0,  Optional = true,  }, --
                    -- { String = 6,   Fret =  0,  Optional = true,  }, --
                },

                G = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- 13
                    { String = 2,   Fret =  3,  Optional = false, }, -- 5
                    { String = 3,   Fret =  2,  Optional = false, }, -- 9
                    { String = 4,   Fret =  4,  Optional = false, }, -- 7
                    { String = 5,   Fret =  2,  Optional = false, }, -- 3
                    { String = 6,   Fret =  3,  Optional = false, }, -- R
                },

                C = {
                    { String = 1,   Fret =  5,  Optional = false, }, -- 13
                    { String = 2,   Fret =  3,  Optional = false, }, -- 9
                    { String = 3,   Fret =  4,  Optional = false, }, -- 7
                    { String = 4,   Fret =  2,  Optional = false, }, -- 3
                    { String = 5,   Fret =  3,  Optional = false, }, -- R
                    { String = 6,   Fret =  3,  Optional = true,  }, -- 5
                },

            },
        },

------------------------------------------------------------------------------------------------------------------------
-- Minor Family        Minor = {
            Min = {

                E = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- R
                    { String = 2,   Fret =  0,  Optional = false, }, -- 5
                    { String = 3,   Fret =  0,  Optional = false, }, -- b3
                    { String = 4,   Fret =  2,  Optional = false, }, -- R
                    { String = 5,   Fret =  2,  Optional = false, }, -- 5
                    { String = 6,   Fret =  0,  Optional = false, }, -- R
                },

                A = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- 5
                    { String = 2,   Fret =  1,  Optional = false, }, -- b3
                    { String = 3,   Fret =  2,  Optional = false, }, -- R
                    { String = 4,   Fret =  2,  Optional = false, }, -- 5
                    { String = 5,   Fret =  0,  Optional = false, }, -- R
                    { String = 6,   Fret =  0,  Optional = true,  }, -- 5
                },

                D = {
                    { String = 1,   Fret =  1,  Optional = false, }, -- b3
                    { String = 2,   Fret =  3,  Optional = false, }, -- R
                    { String = 3,   Fret =  2,  Optional = false, }, -- 5
                    { String = 4,   Fret =  0,  Optional = false, }, -- R
                    { String = 5,   Fret =  0,  Optional = true,  }, -- 5
                    { String = 6,   Fret =  1,  Optional = true,  }, -- b3
                },

                G = {
                    { String = 1,   Fret =  3,  Optional = false, }, -- R
                    { String = 2,   Fret =  3,  Optional = false, }, -- 5
                    { String = 3,   Fret =  0,  Optional = false, }, -- R
                    { String = 4,   Fret =  0,  Optional = false, }, -- 5
                    { String = 5,   Fret =  1,  Optional = false, }, -- b3
                    { String = 6,   Fret =  3,  Optional = false, }, -- R
                },

                C = {
                    { String = 1,   Fret =  3,  Optional = false, }, -- 5
                    { String = 2,   Fret =  1,  Optional = false, }, -- R
                    { String = 3,   Fret =  0,  Optional = false, }, -- 5
                    { String = 4,   Fret =  1,  Optional = false, }, -- b3
                    { String = 5,   Fret =  3,  Optional = false, }, -- R
                    { String = 6,   Fret =  3,  Optional = true,  }, -- 5
                },

            },
            Min6 = {                E = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- R
                    { String = 2,   Fret =  2,  Optional = false, }, -- 6
                    { String = 3,   Fret =  0,  Optional = false, }, -- b3
                    { String = 4,   Fret =  2,  Optional = false, }, -- R
                    { String = 5,   Fret =  2,  Optional = false, }, -- 5
                    { String = 6,   Fret =  0,  Optional = false, }, -- R
                },

                A = {
                    { String = 1,   Fret =  2,  Optional = false, }, -- 6
                    { String = 2,   Fret =  1,  Optional = false, }, -- b3
                    { String = 3,   Fret =  2,  Optional = false, }, -- R
                    { String = 4,   Fret =  2,  Optional = false, }, -- 5
                    { String = 5,   Fret =  0,  Optional = false, }, -- R
                    { String = 6,   Fret =  0,  Optional = true,  }, -- 5
                },

                D = {
                    { String = 1,   Fret =  1,  Optional = false, }, -- b3
                    { String = 2,   Fret =  0,  Optional = false, }, -- 6
                    { String = 3,   Fret =  2,  Optional = false, }, -- 5
                    { String = 4,   Fret =  0,  Optional = false, }, -- R
                    { String = 5,   Fret =  0,  Optional = true,  }, -- 5
                    { String = 6,   Fret =  1,  Optional = true,  }, -- b3
                },

                G = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- 6
                    { String = 2,   Fret =  0,  Optional = false, }, -- b3
                    { String = 3,   Fret =  0,  Optional = false, }, -- R
                    { String = 4,   Fret =  0,  Optional = false, }, -- 5
                    { String = 5,   Fret =  1,  Optional = false, }, -- b3
                    { String = 6,   Fret =  3,  Optional = false, }, -- R
                },

                C = {
                    { String = 1,   Fret =  3,  Optional = false, }, -- 5
                    { String = 2,   Fret =  1,  Optional = false, }, -- R
                    { String = 3,   Fret =  2,  Optional = false, }, -- 6
                    { String = 4,   Fret =  1,  Optional = false, }, -- b3
                    { String = 5,   Fret =  3,  Optional = false, }, -- R
                    { String = 6,   Fret =  3,  Optional = true,  }, -- 5
                },

            },            ["Min6/9"] = {

                E = {
                    { String = 1,   Fret =  2,  Optional = false, }, -- 9
                    { String = 2,   Fret =  2,  Optional = false, }, -- 6
                    { String = 3,   Fret =  0,  Optional = false, }, -- b3
                    { String = 4,   Fret =  2,  Optional = false, }, -- R
                    { String = 5,   Fret =  2,  Optional = false, }, -- 5
                    { String = 6,   Fret =  0,  Optional = false, }, -- R
                },

                A = {
                    { String = 1,   Fret =  2,  Optional = false, }, -- 6
                    { String = 2,   Fret =  1,  Optional = false, }, -- b3
                    { String = 3,   Fret =  4,  Optional = false, }, -- 9
                    { String = 4,   Fret =  2,  Optional = false, }, -- 5
                    { String = 5,   Fret =  0,  Optional = false, }, -- R
                    { String = 6,   Fret =  0,  Optional = true,  }, -- 5
                },

                D = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- 9
                    { String = 2,   Fret =  0,  Optional = false, }, -- 6
--                    { String = 3,   Fret =  2,  Optional = false, }, -- 5
                    { String = 3,   Fret = -2,  Optional = false, }, -- b3
                    { String = 4,   Fret =  0,  Optional = false, }, -- R
                    { String = 5,   Fret =  0,  Optional = true,  }, -- 5
                    { String = 6,   Fret =  1,  Optional = true,  }, -- b3
                },

                G = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- 6
                    { String = 2,   Fret = -1,  Optional = false, }, -- b3  (move up to fret 3 for the 5th if desired)
                    { String = 3,   Fret =  2,  Optional = false, }, -- 9
                    { String = 4,   Fret =  0,  Optional = false, }, -- 5
                    { String = 5,   Fret =  1,  Optional = false, }, -- b3
                    { String = 6,   Fret =  3,  Optional = false, }, -- R
                },

                C = {
                    { String = 1,   Fret =  3,  Optional = false, }, -- 5
                    { String = 2,   Fret =  3,  Optional = false, }, -- 9
                    { String = 3,   Fret =  2,  Optional = false, }, -- 6
                    { String = 4,   Fret =  1,  Optional = false, }, -- b3
                    { String = 5,   Fret =  3,  Optional = false, }, -- R
                    { String = 6,   Fret =  3,  Optional = true,  }, -- 5
                },

            },

            MinAdd9 = {

                E = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- R
                    { String = 2,   Fret =  0,  Optional = false, }, -- 5
                    { String = 3,   Fret =  0,  Optional = false, }, -- b3
                    { String = 4,   Fret =  4,  Optional = false, }, -- 9
                    { String = 5,   Fret =  2,  Optional = false, }, -- 5
                    { String = 6,   Fret =  0,  Optional = false, }, -- R
                },

                A = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- 5
                    { String = 2,   Fret =  1,  Optional = false, }, -- b3
                    { String = 3,   Fret =  4,  Optional = false, }, -- 9
                    { String = 4,   Fret =  2,  Optional = false, }, -- 5
                    { String = 5,   Fret =  0,  Optional = false, }, -- R
                    { String = 6,   Fret =  0,  Optional = true,  }, -- 5
                },

                D = {
                    -- { String = 1,   Fret =  1,  Optional = false, }, -- b3
                    -- { String = 2,   Fret =  5,  Optional = false, }, -- 9
                    -- { String = 3,   Fret =  2,  Optional = false, }, -- 5
                    -- { String = 4,   Fret =  0,  Optional = false, }, -- R
                    -- { String = 5,   Fret =  0,  Optional = true,  }, -- 5
                    -- { String = 6,   Fret =  1,  Optional = true,  }, -- b3
                    { String = 1,   Fret =  0,  Optional = false, }, -- 9
                    { String = 2,   Fret = -2,  Optional = false, }, -- 5
                    { String = 3,   Fret = -2,  Optional = false, }, -- b3
                    { String = 4,   Fret =  0,  Optional = false, }, -- R
                    { String = 5,   Fret =  0,  Optional = true,  }, -- 5
                    { String = 6,   Fret =  1,  Optional = true,  }, -- b3
                },

                G = {
                    { String = 1,   Fret =  3,  Optional = false, }, -- R
                    { String = 2,   Fret =  3,  Optional = false, }, -- 5
                    { String = 3,   Fret =  2,  Optional = false, }, -- 9
                    { String = 4,   Fret =  0,  Optional = false, }, -- 5
                    { String = 5,   Fret =  1,  Optional = false, }, -- b3
                    { String = 6,   Fret =  3,  Optional = false, }, -- R
                },

                C = {
                    { String = 1,   Fret =  3,  Optional = false, }, -- 5
                    { String = 2,   Fret =  3,  Optional = false, }, -- 9
                    { String = 3,   Fret =  0,  Optional = false, }, -- 5
                    { String = 4,   Fret =  1,  Optional = false, }, -- b3
                    { String = 5,   Fret =  3,  Optional = false, }, -- R
                    { String = 6,   Fret =  3,  Optional = true,  }, -- 5
                },

            },

            MinMaj7 = {

                E = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- R
                    { String = 2,   Fret =  0,  Optional = false, }, -- 5
                    { String = 3,   Fret =  0,  Optional = false, }, -- b3
                    { String = 4,   Fret =  1,  Optional = false, }, -- 7
                    { String = 5,   Fret =  2,  Optional = false, }, -- 5
                    { String = 6,   Fret =  0,  Optional = false, }, -- R
                },

                A = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- 5
                    { String = 2,   Fret =  1,  Optional = false, }, -- b3
                    { String = 3,   Fret =  1,  Optional = false, }, -- 7
                    { String = 4,   Fret =  2,  Optional = false, }, -- 5
                    { String = 5,   Fret =  0,  Optional = false, }, -- R
                    { String = 6,   Fret =  0,  Optional = true,  }, -- 5
                },

                D = {
                    { String = 1,   Fret =  1,  Optional = false, }, -- b3
                    { String = 2,   Fret =  2,  Optional = false, }, -- 7
                    { String = 3,   Fret =  2,  Optional = false, }, -- 5
                    { String = 4,   Fret =  0,  Optional = false, }, -- R
                    { String = 5,   Fret =  0,  Optional = true,  }, -- 5
                    { String = 6,   Fret =  1,  Optional = true,  }, -- b3
                },

                G = {
                    { String = 1,   Fret =  2,  Optional = false, }, -- 7
                    { String = 2,   Fret =  3,  Optional = false, }, -- 5
                    { String = 3,   Fret =  0,  Optional = false, }, -- R
                    { String = 4,   Fret =  0,  Optional = false, }, -- 5
                    { String = 5,   Fret =  1,  Optional = false, }, -- b3
                    { String = 6,   Fret =  3,  Optional = false, }, -- R
                },

                C = {
                    { String = 1,   Fret =  3,  Optional = false, }, -- 5
                    { String = 2,   Fret =  1,  Optional = false, }, -- R
                    { String = 3,   Fret =  4,  Optional = false, }, -- 7
                    { String = 4,   Fret =  1,  Optional = false, }, -- 3
                    { String = 5,   Fret =  3,  Optional = false, }, -- R
                    { String = 6,   Fret =  3,  Optional = true,  }, -- 5
                },

           },

            Min7 = {

                E = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- R
                    { String = 2,   Fret =  0,  Optional = false, }, -- 5
                    { String = 3,   Fret =  0,  Optional = false, }, -- b3
                    { String = 4,   Fret =  0,  Optional = false, }, -- b7
                    { String = 5,   Fret =  2,  Optional = false, }, -- 5
                    { String = 6,   Fret =  0,  Optional = false, }, -- R
                },

                A = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- 5
                    { String = 2,   Fret =  1,  Optional = false, }, -- b3
                    { String = 3,   Fret =  0,  Optional = false, }, -- b7
                    { String = 4,   Fret =  2,  Optional = false, }, -- 5
                    { String = 5,   Fret =  0,  Optional = false, }, -- R
                    { String = 6,   Fret =  0,  Optional = true,  }, -- 5
                },

                D = {
                    { String = 1,   Fret =  1,  Optional = false, }, -- b3
                    { String = 2,   Fret =  1,  Optional = false, }, -- b7
                    { String = 3,   Fret =  2,  Optional = false, }, -- 5
                    { String = 4,   Fret =  0,  Optional = false, }, -- R
                    { String = 5,   Fret =  0,  Optional = true,  }, -- 5
                    { String = 6,   Fret =  1,  Optional = true,  }, -- b3
                },

                G = {
                    { String = 1,   Fret =  1,  Optional = false, }, -- b7
                    { String = 2,   Fret =  3,  Optional = false, }, -- 5
                    { String = 3,   Fret =  0,  Optional = false, }, -- R
                    { String = 4,   Fret =  0,  Optional = false, }, -- 5
                    { String = 5,   Fret =  1,  Optional = false, }, -- b3
                    { String = 6,   Fret =  3,  Optional = false, }, -- R
                },

                C = {
                    { String = 1,   Fret =  3,  Optional = false, }, -- 5
                    { String = 2,   Fret =  1,  Optional = false, }, -- R
                    { String = 3,   Fret =  3,  Optional = false, }, -- b7
                    { String = 4,   Fret =  1,  Optional = false, }, -- 3
                    { String = 5,   Fret =  3,  Optional = false, }, -- R
                    { String = 6,   Fret =  3,  Optional = true,  }, -- 5
                },

            },
            Min7b5 = {                E = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- R
                    { String = 2,   Fret = -1,  Optional = false, }, -- b5
                    { String = 3,   Fret =  0,  Optional = false, }, -- b3
                    { String = 4,   Fret =  0,  Optional = false, }, -- b7
                    { String = 5,   Fret =  1,  Optional = false, }, -- b5
                    { String = 6,   Fret =  0,  Optional = false, }, -- R
                },

                A = {
                    { String = 1,   Fret = -1,  Optional = false, }, -- b5
                    { String = 2,   Fret =  1,  Optional = false, }, -- b3
                    { String = 3,   Fret =  0,  Optional = false, }, -- b7
                    { String = 4,   Fret =  1,  Optional = false, }, -- b5
                    { String = 5,   Fret =  0,  Optional = false, }, -- R
                    { String = 6,   Fret = -1,  Optional = true,  }, -- b5
                },

                D = {
                    { String = 1,   Fret =  1,  Optional = false, }, -- b3
                    { String = 2,   Fret =  1,  Optional = false, }, -- b7
                    { String = 3,   Fret =  1,  Optional = false, }, -- b5
                    { String = 4,   Fret =  0,  Optional = false, }, -- R
                    { String = 5,   Fret = -1,  Optional = true,  }, -- b5
                    { String = 6,   Fret =  1,  Optional = true,  }, -- b3
                },

                G = {
                    { String = 1,   Fret =  1,  Optional = false, }, -- b7
    --                { String = 2,   Fret = -1,  Optional = false, }, -- b3
                    { String = 2,   Fret =  2,  Optional = false, }, -- b5
                    { String = 3,   Fret =  0,  Optional = false, }, -- R
                    { String = 4,   Fret = -1,  Optional = false, }, -- b5
                    { String = 5,   Fret =  1,  Optional = false, }, -- b3
                    { String = 6,   Fret =  3,  Optional = false, }, -- R
                },

                C = {
    --                { String = 1,   Fret = -1,  Optional = false, }, -- b3
                    { String = 1,   Fret =  2,  Optional = false, }, -- b5
                    { String = 2,   Fret =  1,  Optional = false, }, -- R
                    { String = 3,   Fret =  3,  Optional = false, }, -- b7
                    { String = 4,   Fret =  1,  Optional = false, }, -- 3
                    { String = 5,   Fret =  3,  Optional = false, }, -- R
                    { String = 6,   Fret =  2,  Optional = true,  }, -- b5
                },

            },
            ['Min7#5'] = {

                E = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- R
                    { String = 2,   Fret =  1,  Optional = false, }, -- #5
                    { String = 3,   Fret =  0,  Optional = false, }, -- b3
                    { String = 4,   Fret =  0,  Optional = false, }, -- b7
                    { String = 5,   Fret =  3,  Optional = false, }, -- #5
                    { String = 6,   Fret =  0,  Optional = false, }, -- R
                },

                A = {
                    { String = 1,   Fret =  1,  Optional = false, }, -- #5
                    { String = 2,   Fret =  1,  Optional = false, }, -- b3
                    { String = 3,   Fret =  0,  Optional = false, }, -- b7
                    { String = 4,   Fret =  3,  Optional = false, }, -- #5
                    { String = 5,   Fret =  0,  Optional = false, }, -- R
                    { String = 6,   Fret =  1,  Optional = true,  }, -- #5
                },

                D = {
                    { String = 1,   Fret =  1,  Optional = false, }, -- b3
                    { String = 2,   Fret =  1,  Optional = false, }, -- b7
                    { String = 3,   Fret =  3,  Optional = false, }, -- #5
                    { String = 4,   Fret =  0,  Optional = false, }, -- R
                    { String = 5,   Fret =  1,  Optional = true,  }, -- #5
                    { String = 6,   Fret =  1,  Optional = true,  }, -- b3
                },

                G = {
                    { String = 1,   Fret =  1,  Optional = false, }, -- b7
                    { String = 2,   Fret = -1,  Optional = false, }, -- b3  (move up to fret 4 for the #5th if desired)
                    { String = 3,   Fret =  0,  Optional = false, }, -- R
                    { String = 4,   Fret =  1,  Optional = false, }, -- #5
                    { String = 5,   Fret =  1,  Optional = false, }, -- b3
                    { String = 6,   Fret =  3,  Optional = false, }, -- R
                },

                C = {
                    { String = 1,   Fret =  4,  Optional = false, }, -- #5
                    { String = 2,   Fret =  1,  Optional = false, }, -- R
                    { String = 3,   Fret =  3,  Optional = false, }, -- b7
                    { String = 4,   Fret =  1,  Optional = false, }, -- b3
                    { String = 5,   Fret =  3,  Optional = false, }, -- R
                    { String = 6,   Fret =  4,  Optional = true,  }, -- #5
                },

            },

            Min9 = {

                E = {
                    { String = 1,   Fret =  2,  Optional = false, }, -- 9
                    { String = 2,   Fret =  0,  Optional = false, }, -- 5
                    { String = 3,   Fret =  0,  Optional = false, }, -- b3
                    { String = 4,   Fret =  0,  Optional = false, }, -- b7
                    { String = 5,   Fret =  2,  Optional = false, }, -- 5
                    { String = 6,   Fret =  0,  Optional = false, }, -- R
                },

                A = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- 5
                    { String = 2,   Fret =  0,  Optional = false, }, -- 9
                    { String = 3,   Fret =  0,  Optional = false, }, -- b7
                    { String = 4,   Fret = -2,  Optional = false, }, -- b3
                    { String = 5,   Fret =  0,  Optional = false, }, -- R
                    { String = 6,   Fret =  0,  Optional = true,  }, -- 5
                },

                D = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- 9
                    { String = 2,   Fret =  1,  Optional = false, }, -- b7
                    { String = 3,   Fret =  2,  Optional = false, }, -- 5
                    { String = 4,   Fret =  0,  Optional = false, }, -- R
                    { String = 5,   Fret =  0,  Optional = true,  }, -- 5
                    { String = 6,   Fret =  1,  Optional = true,  }, -- b3
                },

                G = {
                    { String = 1,   Fret =  3,  Optional = false, }, -- R
                    { String = 2,   Fret =  3,  Optional = false, }, -- 5
                    { String = 3,   Fret =  2,  Optional = false, }, -- 9
                    { String = 4,   Fret =  3,  Optional = false, }, -- b7
                    { String = 5,   Fret =  1,  Optional = false, }, -- b3
                    { String = 6,   Fret =  3,  Optional = false, }, -- R
                },

                C = { -- this is the same as the 'A' form, just with a different root fret
                    { String = 1,   Fret =  3,  Optional = false, }, -- 5
                    { String = 2,   Fret =  3,  Optional = false, }, -- 9
                    { String = 3,   Fret =  3,  Optional = false, }, -- b7
                    { String = 4,   Fret =  1,  Optional = false, }, -- b3
                    { String = 5,   Fret =  3,  Optional = false, }, -- R
                    { String = 6,   Fret =  3,  Optional = true,  }, -- 5
                },

            },

            Min7b9 = {

                E = {
                    { String = 1,   Fret =  1,  Optional = false, }, -- b9
                    { String = 2,   Fret =  0,  Optional = false, }, -- 5
                    { String = 3,   Fret =  0,  Optional = false, }, -- b3
                    { String = 4,   Fret =  0,  Optional = false, }, -- b7
                    { String = 5,   Fret =  2,  Optional = false, }, -- 5
                    { String = 6,   Fret =  0,  Optional = false, }, -- R
                },

                A = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- 5
                    { String = 2,   Fret = -1,  Optional = false, }, -- b9
                    { String = 3,   Fret =  0,  Optional = false, }, -- b7
                    { String = 4,   Fret =  2,  Optional = false, }, -- 5
                    { String = 5,   Fret =  0,  Optional = false, }, -- R
                    { String = 6,   Fret =  0,  Optional = true,  }, -- 5
                },

                D = {
                    { String = 1,   Fret = -1,  Optional = false, }, -- b9
                    { String = 2,   Fret =  1,  Optional = false, }, -- b7
                    { String = 3,   Fret =  2,  Optional = false, }, -- 5
                    { String = 4,   Fret =  0,  Optional = false, }, -- R
                    { String = 5,   Fret =  0,  Optional = true,  }, -- 5
                    { String = 6,   Fret =  1,  Optional = true,  }, -- b3
                },

                G = {
                    { String = 1,   Fret =  4,  Optional = false, }, -- b9
                    { String = 2,   Fret =  3,  Optional = false, }, -- 5
                    { String = 3,   Fret =  0,  Optional = false, }, -- R
                    { String = 4,   Fret =  3,  Optional = false, }, -- b7
                    { String = 5,   Fret =  1,  Optional = false, }, -- b3
                    { String = 6,   Fret =  3,  Optional = false, }, -- R
                },

                C = {
                    { String = 1,   Fret =  3,  Optional = false, }, -- 5  (move down to fret 0 for the 3rd if desired)
                    { String = 2,   Fret =  2,  Optional = false, }, -- b9
                    { String = 3,   Fret =  3,  Optional = false, }, -- b7
                    { String = 4,   Fret =  1,  Optional = false, }, -- b3
                    { String = 5,   Fret =  3,  Optional = false, }, -- R
                    { String = 6,   Fret =  3,  Optional = true,  }, -- 5
                },

            },

            Min11 = {

                E = {
                    { String = 1,   Fret =  2,  Optional = false, }, -- 9
                    { String = 2,   Fret =  0,  Optional = false, }, -- 5
                    { String = 3,   Fret =  0,  Optional = false, }, -- b3
                    { String = 4,   Fret =  0,  Optional = false, }, -- b7
                    { String = 5,   Fret =  0,  Optional = false, }, -- 11
                    { String = 6,   Fret =  0,  Optional = false, }, -- R
                },

                A = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- 5
                    { String = 2,   Fret =  1,  Optional = false, }, -- b3
                    { String = 3,   Fret =  0,  Optional = false, }, -- b7
                    { String = 4,   Fret =  0,  Optional = false, }, -- 11
                    { String = 5,   Fret =  0,  Optional = false, }, -- R
                    { String = 6,   Fret =  0,  Optional = true,  }, -- 5
                },

                D = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- 9 (possibly move this up to fret 1 to get b3)
                    { String = 2,   Fret =  1,  Optional = false, }, -- b7
                    { String = 3,   Fret =  0,  Optional = false, }, -- 11
                    { String = 4,   Fret =  0,  Optional = false, }, -- R
                    { String = 5,   Fret =  0,  Optional = true,  }, -- 5
                    { String = 6,   Fret =  1,  Optional = true,  }, -- b3
                },

                -- G = {
                    -- { String = 1,   Fret =  3,  Optional = false, }, --
                    -- { String = 2,   Fret =  3,  Optional = false, }, --
                    -- { String = 3,   Fret =  3,  Optional = false, }, --
                    -- { String = 4,   Fret =  3,  Optional = false, }, --
                    -- { String = 5,   Fret =  3,  Optional = false, }, --
                    -- { String = 6,   Fret =  3,  Optional = false, }, -- R
                -- },

                C = {
                    { String = 1,   Fret =  1,  Optional = false, }, -- 11
                    { String = 2,   Fret =  3,  Optional = false, }, -- 9
                    { String = 3,   Fret =  3,  Optional = false, }, -- b7
                    { String = 4,   Fret =  1,  Optional = false, }, -- b3
                    { String = 5,   Fret =  3,  Optional = false, }, -- R
                    { String = 6,   Fret =  3,  Optional = true,  }, -- 5
                },

            },

            Min13 = {

                E = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- R
                    { String = 2,   Fret =  2,  Optional = false, }, -- 6 (13)
                    { String = 3,   Fret =  0,  Optional = false, }, -- b3
                    { String = 4,   Fret =  0,  Optional = false, }, -- b7
                    { String = 5,   Fret =  2,  Optional = false, }, -- 5
                    { String = 6,   Fret =  0,  Optional = false, }, -- R
                },

                A = {
                    { String = 1,   Fret =  2,  Optional = false, }, -- 13
                    { String = 2,   Fret =  0,  Optional = false, }, -- 9
                    { String = 3,   Fret =  0,  Optional = false, }, -- b7
                    { String = 4,   Fret = -2,  Optional = false, }, -- b3
                    { String = 5,   Fret =  0,  Optional = false, }, -- R
                    { String = 6,   Fret =  0,  Optional = true,  }, -- 5
                },

                D = {
                    -- { String = 1,   Fret =  0,  Optional = false, }, --
                    -- { String = 2,   Fret =  0,  Optional = false, }, --
                    -- { String = 3,   Fret =  0,  Optional = false, }, --
                    -- { String = 4,   Fret =  0,  Optional = false, }, -- R
                    -- { String = 5,   Fret =  0,  Optional = true,  }, --
                    -- { String = 6,   Fret =  0,  Optional = true,  }, --
                },

                G = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- 13
                    { String = 2,   Fret =  3,  Optional = false, }, -- 5
                    { String = 3,   Fret =  2,  Optional = false, }, -- 9
                    { String = 4,   Fret =  3,  Optional = false, }, -- b7
                    { String = 5,   Fret =  1,  Optional = false, }, -- b3
                    { String = 6,   Fret =  3,  Optional = false, }, -- R
                },

                C = {
                    { String = 1,   Fret =  5,  Optional = false, }, -- 13
                    { String = 2,   Fret =  3,  Optional = false, }, -- 9
                    { String = 3,   Fret =  3,  Optional = false, }, -- b7
                    { String = 4,   Fret =  1,  Optional = false, }, -- b3
                    { String = 5,   Fret =  3,  Optional = false, }, -- R
                    { String = 6,   Fret =  3,  Optional = true,  }, -- 5
                },

            },

        },

------------------------------------------------------------------------------------------------------------------------
-- Dominant Family        Dominant = {
            ['7'] = {
                E = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- R
                    { String = 2,   Fret =  0,  Optional = false, }, -- 5
                    { String = 3,   Fret =  1,  Optional = false, }, -- 3
                    { String = 4,   Fret =  0,  Optional = false, }, -- b7
                    { String = 5,   Fret =  2,  Optional = false, }, -- 5
                    { String = 6,   Fret =  0,  Optional = false, }, -- R
                },

                A = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- 5
                    { String = 2,   Fret =  2,  Optional = false, }, -- 3
                    { String = 3,   Fret =  0,  Optional = false, }, -- b7
                    { String = 4,   Fret =  2,  Optional = false, }, -- 5
                    { String = 5,   Fret =  0,  Optional = false, }, -- R
                    { String = 6,   Fret =  0,  Optional = true,  }, -- 5
                },

                D = {
                    { String = 1,   Fret =  2,  Optional = false, }, -- 3
                    { String = 2,   Fret =  1,  Optional = false, }, -- b7
                    { String = 3,   Fret =  2,  Optional = false, }, -- 5
                    { String = 4,   Fret =  0,  Optional = false, }, -- R
                    { String = 5,   Fret =  0,  Optional = true,  }, -- 5
                    { String = 6,   Fret =  2,  Optional = true,  }, -- 3
                },

                G = {
                    { String = 1,   Fret =  1,  Optional = false, }, -- b7
                    { String = 2,   Fret =  0,  Optional = false, }, -- 3  (move up to fret 3 for the 5th if desired)
                    { String = 3,   Fret =  0,  Optional = false, }, -- R
                    { String = 4,   Fret =  0,  Optional = false, }, -- 5
                    { String = 5,   Fret =  2,  Optional = false, }, -- 3
                    { String = 6,   Fret =  3,  Optional = false, }, -- R
                },

                C = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- 3
                    { String = 2,   Fret =  1,  Optional = false, }, -- R
                    { String = 3,   Fret =  3,  Optional = false, }, -- b7
                    { String = 4,   Fret =  2,  Optional = false, }, -- 3
                    { String = 5,   Fret =  3,  Optional = false, }, -- R
                    { String = 6,   Fret =  3,  Optional = true,  }, -- 5
                },
            },

            ['7Sus4'] = {

                E = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- R
                    { String = 2,   Fret =  0,  Optional = false, }, -- 5
                    { String = 3,   Fret =  2,  Optional = false, }, -- 4
                    { String = 4,   Fret =  0,  Optional = false, }, -- b7
                    { String = 5,   Fret =  2,  Optional = false, }, -- 5
                    { String = 6,   Fret =  0,  Optional = false, }, -- R
                },

                A = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- 5
                    { String = 2,   Fret =  3,  Optional = false, }, -- 4
                    { String = 3,   Fret =  0,  Optional = false, }, -- b7
                    { String = 4,   Fret =  2,  Optional = false, }, -- 5
                    { String = 5,   Fret =  0,  Optional = false, }, -- R
                    { String = 6,   Fret =  0,  Optional = true,  }, -- 5
                },
--[[ Alternate definition
                A = { -- Alternate definition
                    { String = 1,   Fret =  3,  Optional = false, }, -- 5
                    { String = 2,   Fret =  3,  Optional = false, }, -- 4
                    { String = 3,   Fret =  2,  Optional = false, }, -- b7
                    { String = 4,   Fret =  2,  Optional = false, }, -- 5
                    { String = 5,   Fret =  0,  Optional = false, }, -- R
                    { String = 6,   Fret =  0,  Optional = true,  }, -- 5
                },--]]

                D = {
                    { String = 1,   Fret =  3,  Optional = false, }, -- 4
                    { String = 2,   Fret =  1,  Optional = false, }, -- b7
                    { String = 3,   Fret =  2,  Optional = false, }, -- 5
                    { String = 4,   Fret =  0,  Optional = false, }, -- R
                    { String = 5,   Fret =  0,  Optional = true,  }, -- 5
                    { String = 6,   Fret =  3,  Optional = true,  }, -- 3
                },

                G = {
                    { String = 1,   Fret =  1,  Optional = false, }, -- b7
                    { String = 2,   Fret =  1,  Optional = false, }, -- 4
                    { String = 3,   Fret =  0,  Optional = false, }, -- R
                    { String = 4,   Fret =  0,  Optional = false, }, -- 5
                    { String = 5,   Fret =  3,  Optional = false, }, -- 4
                    { String = 6,   Fret =  3,  Optional = false, }, -- R
                },

                C = {
                    { String = 1,   Fret =  1,  Optional = false, }, -- 4
                    { String = 2,   Fret =  1,  Optional = false, }, -- R
                    { String = 3,   Fret =  3,  Optional = false, }, -- b7
                    { String = 4,   Fret =  3,  Optional = false, }, -- 4
                    { String = 5,   Fret =  3,  Optional = false, }, -- R
                    { String = 6,   Fret =  3,  Optional = true,  }, -- 5
                },

            },

            ['7b5'] = {

                E = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- R
                    { String = 2,   Fret =  3,  Optional = false, }, -- b7
                    { String = 3,   Fret =  1,  Optional = false, }, -- 3
                    { String = 4,   Fret =  0,  Optional = false, }, -- b7
                    { String = 5,   Fret =  1,  Optional = false, }, -- b5
                    { String = 6,   Fret =  0,  Optional = false, }, -- R
                },

                A = {
                    { String = 1,   Fret = -1,  Optional = false, }, -- b5
                    { String = 2,   Fret =  2,  Optional = false, }, -- 3
                    { String = 3,   Fret =  0,  Optional = false, }, -- b7
                    { String = 4,   Fret =  1,  Optional = false, }, -- b5
                    { String = 5,   Fret =  0,  Optional = false, }, -- R
                    { String = 6,   Fret = -1,  Optional = true,  }, -- b5
                },

                D = {
                    { String = 1,   Fret =  2,  Optional = false, }, -- 3
                    { String = 2,   Fret =  1,  Optional = false, }, -- b7
                    { String = 3,   Fret =  1,  Optional = false, }, -- b5
                    { String = 4,   Fret =  0,  Optional = false, }, -- R
                    { String = 5,   Fret = -1,  Optional = true,  }, -- b5
                    { String = 6,   Fret =  2,  Optional = true,  }, -- 3
                },

                G = {
                    { String = 1,   Fret =  1,  Optional = false, }, -- b7
                    { String = 2,   Fret =  0,  Optional = false, }, -- 3  (move up to fret 3 for the 5th if desired)
                    { String = 3,   Fret =  0,  Optional = false, }, -- R
                    { String = 4,   Fret = -1,  Optional = false, }, -- b5
                    { String = 5,   Fret =  2,  Optional = false, }, -- 3
                    { String = 6,   Fret =  3,  Optional = false, }, -- R
                },

                C = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- 3
                    { String = 2,   Fret =  1,  Optional = false, }, -- R
                    { String = 3,   Fret =  3,  Optional = false, }, -- b7
                    { String = 4,   Fret =  2,  Optional = false, }, -- 3
                    { String = 5,   Fret =  3,  Optional = false, }, -- R
                    { String = 6,   Fret =  2,  Optional = true,  }, -- b5
                },

            },

            ['7#5'] = {

                E = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- R
                    { String = 2,   Fret =  1,  Optional = false, }, -- #5
                    { String = 3,   Fret =  1,  Optional = false, }, -- 3
                    { String = 4,   Fret =  0,  Optional = false, }, -- b7
                    { String = 5,   Fret =  3,  Optional = false, }, -- #5
                    { String = 6,   Fret =  0,  Optional = false, }, -- R
                },

                A = {
                    { String = 1,   Fret =  1,  Optional = false, }, -- #5
                    { String = 2,   Fret =  2,  Optional = false, }, -- 3
                    { String = 3,   Fret =  0,  Optional = false, }, -- b7
                    { String = 4,   Fret =  3,  Optional = false, }, -- #5
                    { String = 5,   Fret =  0,  Optional = false, }, -- R
                    { String = 6,   Fret =  1,  Optional = true,  }, -- #5
                },

                D = {
                    { String = 1,   Fret =  2,  Optional = false, }, -- 3
                    { String = 2,   Fret =  1,  Optional = false, }, -- b7
                    { String = 3,   Fret =  3,  Optional = false, }, -- #5
                    { String = 4,   Fret =  0,  Optional = false, }, -- R
                    { String = 5,   Fret =  1,  Optional = true,  }, -- #5
                    { String = 6,   Fret =  2,  Optional = true,  }, -- 3
                },

                G = {
                    { String = 1,   Fret =  1,  Optional = false, }, -- b7
                    { String = 2,   Fret =  0,  Optional = false, }, -- 3  (move up to fret 4 for the #5th if desired)
                    { String = 3,   Fret =  0,  Optional = false, }, -- R
                    { String = 4,   Fret =  1,  Optional = false, }, -- #5
                    { String = 5,   Fret =  2,  Optional = false, }, -- 3
                    { String = 6,   Fret =  3,  Optional = false, }, -- R
                },

                C = {
                    { String = 1,   Fret =  4,  Optional = false, }, -- #5
                    { String = 2,   Fret =  1,  Optional = false, }, -- R
                    { String = 3,   Fret =  3,  Optional = false, }, -- b7
                    { String = 4,   Fret =  2,  Optional = false, }, -- 3
                    { String = 5,   Fret =  3,  Optional = false, }, -- R
                    { String = 6,   Fret =  4,  Optional = true,  }, -- #5
                },

            },
            ['7b9'] = {

                E = {
                    { String = 1,   Fret =  1,  Optional = false, }, -- b9
                    { String = 2,   Fret =  0,  Optional = false, }, -- 5
                    { String = 3,   Fret =  1,  Optional = false, }, -- 3
                    { String = 4,   Fret =  0,  Optional = false, }, -- b7
                    { String = 5,   Fret =  2,  Optional = false, }, -- 5
                    { String = 6,   Fret =  0,  Optional = false, }, -- R
                },

                A = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- 5
                    { String = 2,   Fret = -1,  Optional = false, }, -- b9
                    { String = 3,   Fret =  0,  Optional = false, }, -- b7
                    { String = 4,   Fret = -1,  Optional = false, }, -- 3
                    { String = 5,   Fret =  0,  Optional = false, }, -- R
                    { String = 6,   Fret =  0,  Optional = true,  }, -- 5
                },

                D = {
                    { String = 1,   Fret = -1,  Optional = false, }, -- b9
                    { String = 2,   Fret =  1,  Optional = false, }, -- b7
                    { String = 3,   Fret =  2,  Optional = false, }, -- 5
                    { String = 4,   Fret =  0,  Optional = false, }, -- R
                    { String = 5,   Fret =  0,  Optional = true,  }, -- 5
                    { String = 6,   Fret =  2,  Optional = true,  }, -- 3
                },

                G = {
                    { String = 1,   Fret =  3,  Optional = false, }, -- R
                    { String = 2,   Fret =  3,  Optional = false, }, -- 5
                    { String = 3,   Fret =  1,  Optional = false, }, -- b9
                    { String = 4,   Fret =  3,  Optional = false, }, -- b7
                    { String = 5,   Fret =  2,  Optional = false, }, -- 3
                    { String = 6,   Fret =  3,  Optional = false, }, -- R
                },

                C = {
                    { String = 1,   Fret =  3,  Optional = false, }, -- 5  (move down to fret 0 for the 3rd if desired)
                    { String = 2,   Fret =  2,  Optional = false, }, -- b9
                    { String = 3,   Fret =  3,  Optional = false, }, -- b7
                    { String = 4,   Fret =  2,  Optional = false, }, -- 3
                    { String = 5,   Fret =  3,  Optional = false, }, -- R
                    { String = 6,   Fret =  3,  Optional = true,  }, -- 5
                },

            },
            ['7#9'] = {

                E = {
                    { String = 1,   Fret =  3,  Optional = false, }, -- #9
                    { String = 2,   Fret =  0,  Optional = false, }, -- 5
                    { String = 3,   Fret =  1,  Optional = false, }, -- 3
                    { String = 4,   Fret =  0,  Optional = false, }, -- b7
                    { String = 5,   Fret =  2,  Optional = false, }, -- 5
                    { String = 6,   Fret =  0,  Optional = false, }, -- R
                },

                A = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- 5
                    { String = 2,   Fret =  1,  Optional = false, }, -- #9
                    { String = 3,   Fret =  0,  Optional = false, }, -- b7
                    { String = 4,   Fret = -1,  Optional = false, }, -- 3
                    { String = 5,   Fret =  0,  Optional = false, }, -- R
                    { String = 6,   Fret =  0,  Optional = true,  }, -- 5
                },

                D = {
                    { String = 1,   Fret =  1,  Optional = false, }, -- #9
                    { String = 2,   Fret =  1,  Optional = false, }, -- b7
                    { String = 3,   Fret =  2,  Optional = false, }, -- 5
                    { String = 4,   Fret =  0,  Optional = false, }, -- R
                    { String = 5,   Fret =  0,  Optional = true,  }, -- 5
                    { String = 6,   Fret =  2,  Optional = true,  }, -- 3
                },

                G = {
                    { String = 1,   Fret =  3,  Optional = false, }, -- R
                    { String = 2,   Fret =  3,  Optional = false, }, -- 5
                    { String = 3,   Fret =  3,  Optional = false, }, -- #9
                    { String = 4,   Fret =  3,  Optional = false, }, -- b7
                    { String = 5,   Fret =  2,  Optional = false, }, -- 3
                    { String = 6,   Fret =  3,  Optional = false, }, -- R
                },

                C = { -- Purple Haze
                    { String = 1,   Fret =  3,  Optional = false, }, -- 5  (move down to fret 0 for the 3rd if desired)
                    { String = 2,   Fret =  4,  Optional = false, }, -- #9
                    { String = 3,   Fret =  3,  Optional = false, }, -- b7
                    { String = 4,   Fret =  2,  Optional = false, }, -- 3
                    { String = 5,   Fret =  3,  Optional = false, }, -- R
                    { String = 6,   Fret =  3,  Optional = true,  }, -- 5
                },

            },

            ['9'] = {

                E = {
                    { String = 1,   Fret =  2,  Optional = false, }, -- 9
                    { String = 2,   Fret =  0,  Optional = false, }, -- 5
                    { String = 3,   Fret =  1,  Optional = false, }, -- 3
                    { String = 4,   Fret =  0,  Optional = false, }, -- b7
                    { String = 5,   Fret =  2,  Optional = false, }, -- 5
                    { String = 6,   Fret =  0,  Optional = false, }, -- R
                },

                A = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- 5
                    { String = 2,   Fret =  0,  Optional = false, }, -- 9
                    { String = 3,   Fret =  0,  Optional = false, }, -- b7
                    { String = 4,   Fret = -1,  Optional = false, }, -- 3
                    { String = 5,   Fret =  0,  Optional = false, }, -- R
                    { String = 6,   Fret =  0,  Optional = true,  }, -- 5
                },

                D = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- 9
                    { String = 2,   Fret =  1,  Optional = false, }, -- b7
                    { String = 3,   Fret = -1,  Optional = false, }, -- 3
                    { String = 4,   Fret =  0,  Optional = false, }, -- R
                    { String = 5,   Fret =  0,  Optional = true,  }, -- 5
                    { String = 6,   Fret =  2,  Optional = true,  }, -- 3
                },

                G = {
                    { String = 1,   Fret =  3,  Optional = false, }, -- R
                    { String = 2,   Fret =  3,  Optional = false, }, -- 5
                    { String = 3,   Fret =  2,  Optional = false, }, -- 9
                    { String = 4,   Fret =  3,  Optional = false, }, -- b7
                    { String = 5,   Fret =  2,  Optional = false, }, -- 3
                    { String = 6,   Fret =  3,  Optional = false, }, -- R
                },

                C = {
                    { String = 1,   Fret =  3,  Optional = false, }, -- 5
                    { String = 2,   Fret =  3,  Optional = false, }, -- 9
                    { String = 3,   Fret =  3,  Optional = false, }, -- b7
                    { String = 4,   Fret =  2,  Optional = false, }, -- 3
                    { String = 5,   Fret =  3,  Optional = false, }, -- R
                    { String = 6,   Fret =  3,  Optional = true,  }, -- 5
                },

            },

            ['9b5'] = {

                E = {
                    { String = 1,   Fret =  2,  Optional = false, }, -- 9
                    { String = 2,   Fret = -1,  Optional = false, }, -- b5
                    { String = 3,   Fret =  1,  Optional = false, }, -- 3
                    { String = 4,   Fret =  0,  Optional = false, }, -- b7
                    { String = 5,   Fret =  1,  Optional = false, }, -- b5
                    { String = 6,   Fret =  0,  Optional = false, }, -- R
                },

                A = {
                    { String = 1,   Fret = -1,  Optional = false, }, -- b5
                    { String = 2,   Fret =  0,  Optional = false, }, -- 9
                    { String = 3,   Fret =  0,  Optional = false, }, -- b7
                    { String = 4,   Fret = -1,  Optional = false, }, -- 3
                    { String = 5,   Fret =  0,  Optional = false, }, -- R
                    { String = 6,   Fret = -1,  Optional = true,  }, -- b5
                },

                D = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- 9
                    { String = 2,   Fret =  1,  Optional = false, }, -- b7
                    { String = 3,   Fret = -1,  Optional = false, }, -- 3
                    { String = 4,   Fret =  0,  Optional = false, }, -- R
                    { String = 5,   Fret = -1,  Optional = true,  }, -- b5
                    { String = 6,   Fret =  2,  Optional = true,  }, -- 3
                },

                G = {
                    { String = 1,   Fret =  3,  Optional = false, }, -- R
                    { String = 2,   Fret =  2,  Optional = false, }, -- b5
                    { String = 3,   Fret =  2,  Optional = false, }, -- 9
                    { String = 4,   Fret =  3,  Optional = false, }, -- b7
                    { String = 5,   Fret =  2,  Optional = false, }, -- 3
                    { String = 6,   Fret =  3,  Optional = false, }, -- R
                },

                C = {
                    { String = 1,   Fret =  2,  Optional = false, }, -- b5
                    { String = 2,   Fret =  3,  Optional = false, }, -- 9
                    { String = 3,   Fret =  3,  Optional = false, }, -- b7
                    { String = 4,   Fret =  2,  Optional = false, }, -- 3
                    { String = 5,   Fret =  3,  Optional = false, }, -- R
                    { String = 6,   Fret =  2,  Optional = true,  }, -- b5
                },

            },

            ['9#5'] = {

                E = {
                    { String = 1,   Fret =  2,  Optional = false, }, -- 9
                    { String = 2,   Fret =  1,  Optional = false, }, -- #5
                    { String = 3,   Fret =  1,  Optional = false, }, -- 3
                    { String = 4,   Fret =  0,  Optional = false, }, -- b7
                    { String = 5,   Fret =  3,  Optional = false, }, -- #5
                    { String = 6,   Fret =  0,  Optional = false, }, -- R
                },

                A = {
                    { String = 1,   Fret =  1,  Optional = false, }, -- #5
                    { String = 2,   Fret =  0,  Optional = false, }, -- 9
                    { String = 3,   Fret =  0,  Optional = false, }, -- b7
                    { String = 4,   Fret = -1,  Optional = false, }, -- 3
                    { String = 5,   Fret =  0,  Optional = false, }, -- R
                    { String = 6,   Fret =  1,  Optional = true,  }, -- #5
                },

                D = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- 9
                    { String = 2,   Fret =  1,  Optional = false, }, -- b7
                    { String = 3,   Fret = -1,  Optional = false, }, -- 3
                    { String = 4,   Fret =  0,  Optional = false, }, -- R
                    { String = 5,   Fret =  1,  Optional = true,  }, -- #5
                    { String = 6,   Fret =  2,  Optional = true,  }, -- 3
                },

                G = {
                    { String = 1,   Fret =  3,  Optional = false, }, -- R
                    { String = 2,   Fret =  4,  Optional = false, }, -- #5
                    { String = 3,   Fret =  2,  Optional = false, }, -- 9
                    { String = 4,   Fret =  3,  Optional = false, }, -- b7
                    { String = 5,   Fret =  2,  Optional = false, }, -- 3
                    { String = 6,   Fret =  3,  Optional = false, }, -- R
                },

                C = {
                    { String = 1,   Fret =  4,  Optional = false, }, -- #5
                    { String = 2,   Fret =  3,  Optional = false, }, -- 9
                    { String = 3,   Fret =  3,  Optional = false, }, -- b7
                    { String = 4,   Fret =  2,  Optional = false, }, -- 3
                    { String = 5,   Fret =  3,  Optional = false, }, -- R
                    { String = 6,   Fret =  4,  Optional = true,  }, -- #5
                },

            },
            ['9#11'] = {

                E = {
                    { String = 1,   Fret =  2,  Optional = false, }, -- 9
                    { String = 2,   Fret =  3,  Optional = false, }, -- b7
                    { String = 3,   Fret =  3,  Optional = false, }, -- #11
                    { String = 4,   Fret =  2,  Optional = false, }, -- R
                    { String = 5,   Fret =  2,  Optional = false, }, -- 5
                    { String = 6,   Fret =  0,  Optional = false, }, -- R
                },

                A = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- 5
                    { String = 2,   Fret =  0,  Optional = false, }, -- 9
                    { String = 3,   Fret =  0,  Optional = false, }, -- b7
                    { String = 4,   Fret =  1,  Optional = false, }, -- #11
                    { String = 5,   Fret =  0,  Optional = false, }, -- R
                    { String = 6,   Fret =  0,  Optional = true,  }, -- 5
                },

                D = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- 9
                    { String = 2,   Fret =  1,  Optional = false, }, -- b7
                    { String = 3,   Fret =  1,  Optional = false, }, -- #11
                    { String = 4,   Fret =  0,  Optional = false, }, -- R
                    { String = 5,   Fret =  0,  Optional = true,  }, -- 5
                    { String = 6,   Fret =  2,  Optional = true,  }, -- 3
                },

                -- G = {
                    -- { String = 1,   Fret =  3,  Optional = false, }, --
                    -- { String = 2,   Fret =  3,  Optional = false, }, --
                    -- { String = 3,   Fret =  3,  Optional = false, }, --
                    -- { String = 4,   Fret =  3,  Optional = false, }, --
                    -- { String = 5,   Fret =  3,  Optional = false, }, --
                    -- { String = 6,   Fret =  3,  Optional = false, }, -- R
                -- },

                C = {
                    { String = 1,   Fret =  2,  Optional = false, }, -- #11
                    { String = 2,   Fret =  3,  Optional = false, }, -- 9
                    { String = 3,   Fret =  3,  Optional = false, }, -- b7
                    { String = 4,   Fret =  2,  Optional = false, }, -- 3
                    { String = 5,   Fret =  3,  Optional = false, }, -- R
                    { String = 6,   Fret =  3,  Optional = true,  }, -- 5
                },

            },

            ['11'] = {

                -- E = { -- not quite as easily moved around
                    -- { String = 1,   Fret =  2,  Optional = false, }, -- 9
                    -- { String = 2,   Fret =  0,  Optional = false, }, -- 5
                    -- { String = 3,   Fret =  2,  Optional = false, }, -- 11
                    -- { String = 4,   Fret =  0,  Optional = false, }, -- b7
                    -- { String = 5,   Fret =  2,  Optional = false, }, -- 5
                    -- { String = 6,   Fret =  0,  Optional = false, }, -- R
                -- },

                E = {
                    { String = 1,   Fret =  2,  Optional = false, }, -- 9
                    { String = 2,   Fret =  0,  Optional = false, }, -- 5
                    { String = 3,   Fret =  2,  Optional = false, }, -- 11
                    { String = 4,   Fret =  0,  Optional = false, }, -- b7
                    { String = 5,   Fret =  0,  Optional = false, }, -- 11
                    { String = 6,   Fret =  0,  Optional = false, }, -- R
                },

                A = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- 5
                    { String = 2,   Fret =  3,  Optional = false, }, -- 11
                    { String = 3,   Fret =  0,  Optional = false, }, -- b7
                    { String = 4,   Fret =  2,  Optional = false, }, -- 5
                    { String = 5,   Fret =  0,  Optional = false, }, -- R
                    { String = 6,   Fret =  0,  Optional = true,  }, -- 5
                },

                D = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- 9
                    { String = 2,   Fret =  1,  Optional = false, }, -- b7
                    { String = 3,   Fret =  0,  Optional = false, }, -- 11
                    { String = 4,   Fret =  0,  Optional = false, }, -- R
                    { String = 5,   Fret =  0,  Optional = true,  }, -- 5
                    { String = 6,   Fret =  2,  Optional = true,  }, -- 3
                },

                -- G = {
                    -- { String = 1,   Fret =  3,  Optional = false, }, --
                    -- { String = 2,   Fret =  3,  Optional = false, }, --
                    -- { String = 3,   Fret =  3,  Optional = false, }, --
                    -- { String = 4,   Fret =  3,  Optional = false, }, --
                    -- { String = 5,   Fret =  3,  Optional = false, }, --
                    -- { String = 6,   Fret =  3,  Optional = false, }, -- R
                -- },

                C = {
                    { String = 1,   Fret =  1,  Optional = false, }, -- 11
                    { String = 2,   Fret =  3,  Optional = false, }, -- 9
                    { String = 3,   Fret =  3,  Optional = false, }, -- b7
                    { String = 4,   Fret =  2,  Optional = false, }, -- 3
                    { String = 5,   Fret =  3,  Optional = false, }, -- R
                    { String = 6,   Fret =  3,  Optional = true,  }, -- 5
                },

            },

            ['13'] = {                E = {
                    { String = 1,   Fret =  2,  Optional = false, }, -- 9
                    { String = 2,   Fret =  2,  Optional = false, }, -- 6 (13)
                    { String = 3,   Fret =  1,  Optional = false, }, -- 3
                    { String = 4,   Fret =  0,  Optional = false, }, -- b7
                    { String = 5,   Fret =  2,  Optional = false, }, -- 5
                    { String = 6,   Fret =  0,  Optional = false, }, -- R
                },
                A = {
                    { String = 1,   Fret =  2,  Optional = false, }, -- 13
                    { String = 2,   Fret =  0,  Optional = false, }, -- 9
                    { String = 3,   Fret =  0,  Optional = false, }, -- b7
                    { String = 4,   Fret = -1,  Optional = false, }, -- 3
                    { String = 5,   Fret =  0,  Optional = false, }, -- R
                    { String = 6,   Fret =  0,  Optional = true,  }, -- 5
                },

                D = {
                    -- { String = 1,   Fret =  0,  Optional = false, }, --
                    -- { String = 2,   Fret =  0,  Optional = false, }, --
                    -- { String = 3,   Fret =  0,  Optional = false, }, --
                    -- { String = 4,   Fret =  0,  Optional = false, }, -- R
                    -- { String = 5,   Fret =  0,  Optional = true,  }, --
                    -- { String = 6,   Fret =  0,  Optional = true,  }, --
                },

                G = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- 13
                    { String = 2,   Fret =  3,  Optional = false, }, -- 5
                    { String = 3,   Fret =  2,  Optional = false, }, -- 9
                    { String = 4,   Fret =  3,  Optional = false, }, -- b7
                    { String = 5,   Fret =  2,  Optional = false, }, -- 3
                    { String = 6,   Fret =  3,  Optional = false, }, -- R
                },

                C = {
                    { String = 1,   Fret =  5,  Optional = false, }, -- 13
                    { String = 2,   Fret =  3,  Optional = false, }, -- 9
                    { String = 3,   Fret =  3,  Optional = false, }, -- b7
                    { String = 4,   Fret =  2,  Optional = false, }, -- 3
                    { String = 5,   Fret =  3,  Optional = false, }, -- R
                    { String = 6,   Fret =  3,  Optional = true,  }, -- 5
                },
            },

        },

------------------------------------------------------------------------------------------------------------------------
-- Other Chords
        Other = {
            Aug = {

                E = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- R
                    { String = 2,   Fret =  1,  Optional = false, }, -- #5
                    { String = 3,   Fret =  1,  Optional = false, }, -- 3
                    { String = 4,   Fret =  2,  Optional = false, }, -- R
                    { String = 5,   Fret =  3,  Optional = false, }, -- #5
                    { String = 6,   Fret =  0,  Optional = false, }, -- R
                },

                A = {
                    { String = 1,   Fret =  1,  Optional = false, }, -- #5
                    { String = 2,   Fret =  2,  Optional = false, }, -- 3
                    { String = 3,   Fret =  2,  Optional = false, }, -- R
                    { String = 4,   Fret =  3,  Optional = false, }, -- #5
                    { String = 5,   Fret =  0,  Optional = false, }, -- R
                    { String = 6,   Fret =  1,  Optional = true,  }, -- #5
                },

                D = {
                    { String = 1,   Fret =  2,  Optional = false, }, -- 3
                    { String = 2,   Fret =  3,  Optional = false, }, -- R
                    { String = 3,   Fret =  3,  Optional = false, }, -- #5
                    { String = 4,   Fret =  0,  Optional = false, }, -- R
                    { String = 5,   Fret =  1,  Optional = true,  }, -- #5
                    { String = 6,   Fret =  2,  Optional = true,  }, -- 3
                },

                G = {
                    { String = 1,   Fret =  3,  Optional = false, }, -- R
                    { String = 2,   Fret =  0,  Optional = false, }, -- 3  (move up to fret 3 for the 5th if desired)
                    { String = 3,   Fret =  0,  Optional = false, }, -- R
                    { String = 4,   Fret =  1,  Optional = false, }, -- #5
                    { String = 5,   Fret =  2,  Optional = false, }, -- 3
                    { String = 6,   Fret =  3,  Optional = false, }, -- R
                },

                C = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- 3
                    { String = 2,   Fret =  1,  Optional = false, }, -- R
                    { String = 3,   Fret =  1,  Optional = false, }, -- #5
                    { String = 4,   Fret =  2,  Optional = false, }, -- 3
                    { String = 5,   Fret =  3,  Optional = false, }, -- R
                    { String = 6,   Fret =  4,  Optional = true,  }, -- #5
                },

            },

            Dim = {

                E = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- R
                    { String = 2,   Fret = -1,  Optional = false, }, -- b5
                    { String = 3,   Fret =  0,  Optional = false, }, -- b3
                    { String = 4,   Fret =  2,  Optional = false, }, -- R
                    { String = 5,   Fret =  1,  Optional = false, }, -- b5
                    { String = 6,   Fret =  0,  Optional = false, }, -- R
                },

                A = {
                    { String = 1,   Fret = -1,  Optional = false, }, -- b5
                    { String = 2,   Fret =  1,  Optional = false, }, -- b3
                    { String = 3,   Fret =  2,  Optional = false, }, -- R
                    { String = 4,   Fret =  1,  Optional = false, }, -- b5
                    { String = 5,   Fret =  0,  Optional = false, }, -- R
                    { String = 6,   Fret = -1,  Optional = true,  }, -- b5
                },

                D = {
                    { String = 1,   Fret =  1,  Optional = false, }, -- b3
                    { String = 2,   Fret =  3,  Optional = false, }, -- R
                    { String = 3,   Fret =  1,  Optional = false, }, -- b5
                    { String = 4,   Fret =  0,  Optional = false, }, -- R
                    { String = 5,   Fret = -1,  Optional = true,  }, -- b5
                    { String = 6,   Fret =  1,  Optional = true,  }, -- b3
                },

                G = {
                    { String = 1,   Fret =  3,  Optional = false, }, -- R
                    { String = 2,   Fret =  2,  Optional = false, }, -- b5
                    { String = 3,   Fret =  0,  Optional = false, }, -- R
                    { String = 4,   Fret = -1,  Optional = false, }, -- b5
                    { String = 5,   Fret =  1,  Optional = false, }, -- b3
                    { String = 6,   Fret =  3,  Optional = false, }, -- R
                },

                C = {
                    { String = 1,   Fret =  2,  Optional = false, }, -- b5
                    { String = 2,   Fret =  1,  Optional = false, }, -- R
                    { String = 3,   Fret = -1,  Optional = false, }, -- b5
                    { String = 4,   Fret =  1,  Optional = false, }, -- b3
                    { String = 5,   Fret =  3,  Optional = false, }, -- R
                    { String = 6,   Fret =  2,  Optional = true,  }, -- b5
                },

            },

            Dim7 = {

                E = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- R
                    { String = 2,   Fret =  2,  Optional = false, }, -- bb7
                    { String = 3,   Fret =  0,  Optional = false, }, -- b3
                    { String = 4,   Fret =  2,  Optional = false, }, -- R
                    { String = 5,   Fret =  1,  Optional = false, }, -- b5
                    { String = 6,   Fret =  0,  Optional = false, }, -- R
                },

                A = { -- basically the same as the C form
                    { String = 1,   Fret = -1,  Optional = false, }, -- b5
                    { String = 2,   Fret =  1,  Optional = false, }, -- b3
                    { String = 3,   Fret = -1,  Optional = false, }, -- bb7
                    { String = 4,   Fret =  1,  Optional = false, }, -- b5
                    { String = 5,   Fret =  0,  Optional = false, }, -- R
                    { String = 6,   Fret = -1,  Optional = true,  }, -- b5
                },

                D = {
                    { String = 1,   Fret =  1,  Optional = false, }, -- b3
                    { String = 2,   Fret =  0,  Optional = false, }, -- bb7
                    { String = 3,   Fret =  1,  Optional = false, }, -- b5
                    { String = 4,   Fret =  0,  Optional = false, }, -- R
                    { String = 5,   Fret = -1,  Optional = true,  }, -- b5
                    { String = 6,   Fret =  1,  Optional = true,  }, -- b3
                },

                G = {
                    { String = 1,   Fret =  3,  Optional = false, }, -- R
                    { String = 2,   Fret =  2,  Optional = false, }, -- b5
                    { String = 3,   Fret =  3,  Optional = false, }, -- b3
                    { String = 4,   Fret =  2,  Optional = false, }, -- bb7
                    { String = 5,   Fret =  1,  Optional = false, }, -- b3  (optionally move this to fret 4 for b5)
                    { String = 6,   Fret =  3,  Optional = false, }, -- R
                },

                C = {
                    { String = 1,   Fret =  2,  Optional = false, }, -- b5
                    { String = 2,   Fret =  4,  Optional = false, }, -- b3
                    { String = 3,   Fret =  2,  Optional = false, }, -- bb7
                    { String = 4,   Fret =  4,  Optional = false, }, -- b5
                    { String = 5,   Fret =  3,  Optional = false, }, -- R
                    { String = 6,   Fret =  2,  Optional = true,  }, -- b5
                },

            },

            Sus2 = { -- compare this to MajAdd9

                E = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- R
                    { String = 2,   Fret =  0,  Optional = false, }, -- 5
                    { String = 3,   Fret = -1,  Optional = false, }, -- 9 (2)
                    { String = 4,   Fret =  4,  Optional = false, }, -- 9 (2)
                    { String = 5,   Fret =  2,  Optional = false, }, -- 5
                    { String = 6,   Fret =  0,  Optional = false, }, -- R
                },

                A = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- 5
                    { String = 2,   Fret =  0,  Optional = false, }, -- 9 (2)
                    { String = 3,   Fret =  4,  Optional = false, }, -- 9 (2)  (do I want to make this one R ???)
                    { String = 4,   Fret =  2,  Optional = false, }, -- 5
                    { String = 5,   Fret =  0,  Optional = false, }, -- R
                    { String = 6,   Fret =  0,  Optional = true,  }, -- 5
                },

                D = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- 9 (2)
                    { String = 2,   Fret =  3,  Optional = false, }, -- R
                    { String = 3,   Fret =  2,  Optional = false, }, -- 5
                    { String = 4,   Fret =  0,  Optional = false, }, -- R
                    { String = 5,   Fret =  0,  Optional = true,  }, -- 5
                    { String = 6,   Fret =  0,  Optional = true,  }, -- 9 (2)
                },

                G = {
                    { String = 1,   Fret =  3,  Optional = false, }, -- R
                    { String = 2,   Fret =  3,  Optional = false, }, -- 5
                    { String = 3,   Fret =  2,  Optional = false, }, -- 9 (2)
                    { String = 4,   Fret =  0,  Optional = false, }, -- 5
                    { String = 5,   Fret =  0,  Optional = false, }, -- 9 (2)
                    { String = 6,   Fret =  3,  Optional = false, }, -- R
                },

                C = {
                    { String = 1,   Fret =  3,  Optional = false, }, -- 5
                    { String = 2,   Fret =  3,  Optional = false, }, -- 9 (2)
                    { String = 3,   Fret =  0,  Optional = false, }, -- 5
                    { String = 4,   Fret =  0,  Optional = true , }, -- 9 (2)
                    { String = 5,   Fret =  3,  Optional = false, }, -- R
                    { String = 6,   Fret =  3,  Optional = true,  }, -- 5
                },

            },
            Sus4 = {

                E = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- R
                    { String = 2,   Fret =  0,  Optional = false, }, -- 5
                    { String = 3,   Fret =  2,  Optional = false, }, -- 4
                    { String = 4,   Fret =  2,  Optional = false, }, -- R
                    { String = 5,   Fret =  2,  Optional = false, }, -- 5
                    { String = 6,   Fret =  0,  Optional = false, }, -- R
                },

                A = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- 5
                    { String = 2,   Fret =  3,  Optional = false, }, -- 4
                    { String = 3,   Fret =  2,  Optional = false, }, -- R
                    { String = 4,   Fret =  2,  Optional = false, }, -- 5
                    { String = 5,   Fret =  0,  Optional = false, }, -- R
                    { String = 6,   Fret =  0,  Optional = true,  }, -- 5
                },

                D = {
                    { String = 1,   Fret =  3,  Optional = false, }, -- 4
                    { String = 2,   Fret =  3,  Optional = false, }, -- R
                    { String = 3,   Fret =  2,  Optional = false, }, -- 5
                    { String = 4,   Fret =  0,  Optional = false, }, -- R
                    { String = 5,   Fret =  0,  Optional = true,  }, -- 5
                    { String = 6,   Fret =  3,  Optional = true,  }, -- 4
                },

                G = {
                    { String = 1,   Fret =  3,  Optional = false, }, -- R
                    { String = 2,   Fret =  1,  Optional = false, }, -- 4
                    { String = 3,   Fret =  0,  Optional = false, }, -- R
                    { String = 4,   Fret =  0,  Optional = false, }, -- 5
                    { String = 5,   Fret =  3,  Optional = false, }, -- 4
                    { String = 6,   Fret =  3,  Optional = false, }, -- R
                },

                C = {
                    { String = 1,   Fret =  1,  Optional = false, }, -- 4
                    { String = 2,   Fret =  1,  Optional = false, }, -- R
                    { String = 3,   Fret =  0,  Optional = false, }, -- 5
                    { String = 4,   Fret =  3,  Optional = false, }, -- 4
                    { String = 5,   Fret =  3,  Optional = false, }, -- R
                    { String = 6,   Fret =  3,  Optional = true,  }, -- 5
                },

            },
        },
------------------------------------------------------------------------------------------------------------------------
-- Triad and 7th Inversions

        Inversions = {

            Maj = {                -- Note that ['1'] and ['4'] result in the same chord, just an octave apart                -- (or the exact same chord if you choose roots that are an octave apart)

                ['1'] = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- R
                    { String = 2,   Fret =  0,  Optional = false, }, -- 5
                    { String = 3,   Fret =  1,  Optional = false, }, -- 3
                    { String = 4,   Fret =  2,  Optional = false, }, -- R
                },
                ['2'] = {
                    { String = 1,   Fret = -1,  Optional = false, }, -- 3
                    { String = 2,   Fret =  0,  Optional = false, }, -- R
                    { String = 3,   Fret = -1,  Optional = false, }, -- 5
                    { String = 4,   Fret =  1,  Optional = false, }, -- 3
                },
                ['3'] = {
                    { String = 1,   Fret = -2,  Optional = false, }, -- 5
                    { String = 2,   Fret =  0,  Optional = false, }, -- 3
                    { String = 3,   Fret =  0,  Optional = false, }, -- R
                    { String = 4,   Fret =  0,  Optional = false, }, -- 5
                },
                ['4'] = {
                    { String = 1,   Fret = -2,  Optional = false, }, -- R
                    { String = 2,   Fret = -2,  Optional = false, }, -- 5
                    { String = 3,   Fret = -1,  Optional = false, }, -- 3
                    { String = 4,   Fret =  0,  Optional = false, }, -- R
                },

            },

            Min = {
                -- Note that ['1'] and ['4'] result in the same chord, just an octave apart
                -- (or the exact same chord if you choose roots that are an octave apart)

                ['1'] = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- R
                    { String = 2,   Fret =  0,  Optional = false, }, -- 5
                    { String = 3,   Fret =  0,  Optional = false, }, -- b3
                    { String = 4,   Fret =  2,  Optional = false, }, -- R
                },
                ['2'] = {
                    { String = 1,   Fret = -2,  Optional = false, }, -- b3
                    { String = 2,   Fret =  0,  Optional = false, }, -- R
                    { String = 3,   Fret = -1,  Optional = false, }, -- 5
                    { String = 4,   Fret =  0,  Optional = false, }, -- b3
                },
                ['3'] = {
                    { String = 1,   Fret = -2,  Optional = false, }, -- 5
                    { String = 2,   Fret = -1,  Optional = false, }, -- b3
                    { String = 3,   Fret =  0,  Optional = false, }, -- R
                    { String = 4,   Fret =  0,  Optional = false, }, -- 5
                },
                ['4'] = {
                    { String = 1,   Fret = -2,  Optional = false, }, -- R
                    { String = 2,   Fret = -2,  Optional = false, }, -- 5
                    { String = 3,   Fret = -2,  Optional = false, }, -- b3
                    { String = 4,   Fret =  0,  Optional = false, }, -- R
                },

            },

            Aug = {

                -- Note that ['1'] and ['4'] result in the same chord, just an octave apart
                -- (or the exact same chord if you choose roots that are an octave apart)

                ['1'] = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- R
                    { String = 2,   Fret =  1,  Optional = false, }, -- #5
                    { String = 3,   Fret =  1,  Optional = false, }, -- 3
                    { String = 4,   Fret =  2,  Optional = false, }, -- R
                },

                ['2'] = {
                    { String = 1,   Fret = -1,  Optional = false, }, -- 3
                    { String = 2,   Fret =  0,  Optional = false, }, -- R
                    { String = 3,   Fret =  0,  Optional = false, }, -- #5
                    { String = 4,   Fret =  1,  Optional = false, }, -- 3
                },

                ['3'] = {
                    { String = 1,   Fret = -1,  Optional = false, }, -- #5
                    { String = 2,   Fret =  0,  Optional = false, }, -- 3
                    { String = 3,   Fret =  0,  Optional = false, }, -- R
                    { String = 4,   Fret =  1,  Optional = false, }, -- #5
                },

                ['4'] = {
                    { String = 1,   Fret = -2,  Optional = false, }, -- R
                    { String = 2,   Fret = -1,  Optional = false, }, -- #5
                    { String = 3,   Fret = -1,  Optional = false, }, -- 3
                    { String = 4,   Fret =  0,  Optional = false, }, -- R
                },

            },

            Dim = {

                -- Note that ['1'] and ['4'] result in the same chord, just an octave apart
                -- (or the exact same chord if you choose roots that are an octave apart)

                ['1'] = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- R
                    { String = 2,   Fret = -1,  Optional = false, }, -- b5
                    { String = 3,   Fret =  0,  Optional = false, }, -- b3
                    { String = 4,   Fret =  2,  Optional = false, }, -- R
                },

                ['2'] = {
                    { String = 1,   Fret = -2,  Optional = false, }, -- b3
                    { String = 2,   Fret =  0,  Optional = false, }, -- R
                    { String = 3,   Fret = -2,  Optional = false, }, -- b5
                    { String = 4,   Fret =  0,  Optional = false, }, -- b3
                },

                ['3'] = {
                    { String = 1,   Fret = -3,  Optional = false, }, -- b5
                    { String = 2,   Fret = -1,  Optional = false, }, -- b3
                    { String = 3,   Fret =  0,  Optional = false, }, -- R
                    { String = 4,   Fret = -1,  Optional = false, }, -- b5
                },

                ['4'] = {
                    { String = 1,   Fret = -2,  Optional = false, }, -- R
                    { String = 2,   Fret = -3,  Optional = false, }, -- b5
                    { String = 3,   Fret = -2,  Optional = false, }, -- b3
                    { String = 4,   Fret =  0,  Optional = false, }, -- R
                },

            },

            Maj6 = {

                ['1'] = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- R
                    { String = 2,   Fret =  0,  Optional = false, }, -- 5
                    { String = 3,   Fret =  1,  Optional = false, }, -- 3
                    { String = 4,   Fret = -1,  Optional = false, }, -- 6
                },

                ['2'] = {
                    { String = 1,   Fret =  2,  Optional = false, }, -- 5
                    { String = 2,   Fret =  0,  Optional = false, }, -- R
                    { String = 3,   Fret =  1,  Optional = false, }, -- 6
                    { String = 4,   Fret =  1,  Optional = false, }, -- 3
                },

                ['3'] = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- 6
                    { String = 2,   Fret =  0,  Optional = false, }, -- 3
                    { String = 3,   Fret =  0,  Optional = false, }, -- R
                    { String = 4,   Fret =  0,  Optional = false, }, -- 5
                },

                ['4'] = {
                    { String = 1,   Fret =  2,  Optional = false, }, -- 3
                    { String = 2,   Fret =  0,  Optional = false, }, -- 6
                    { String = 3,   Fret =  2,  Optional = false, }, -- 5
                    { String = 4,   Fret =  0,  Optional = false, }, -- R
                },

            },

            Min6 = {

                ['1'] = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- R
                    { String = 2,   Fret =  0,  Optional = false, }, -- 5
                    { String = 3,   Fret =  0,  Optional = false, }, -- b3
                    { String = 4,   Fret = -1,  Optional = false, }, -- 6
                },

                ['2'] = {
                    { String = 1,   Fret =  2,  Optional = false, }, -- 5
                    { String = 2,   Fret =  0,  Optional = false, }, -- R
                    { String = 3,   Fret =  1,  Optional = false, }, -- 6
                    { String = 4,   Fret =  0,  Optional = false, }, -- b3
                },

                ['3'] = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- 6
                    { String = 2,   Fret = -1,  Optional = false, }, -- b3
                    { String = 3,   Fret =  0,  Optional = false, }, -- R
                    { String = 4,   Fret =  0,  Optional = false, }, -- 5
                },

                ['4'] = {
                    { String = 1,   Fret =  1,  Optional = false, }, -- b3
                    { String = 2,   Fret =  0,  Optional = false, }, -- 6
                    { String = 3,   Fret =  2,  Optional = false, }, -- 5
                    { String = 4,   Fret =  0,  Optional = false, }, -- R
                },

            },

            Maj7 = {

                ['1'] = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- R
                    { String = 2,   Fret =  0,  Optional = false, }, -- 5
                    { String = 3,   Fret =  1,  Optional = false, }, -- 3
                    { String = 4,   Fret =  1,  Optional = false, }, -- 7
                },

                ['2'] = {
                    { String = 1,   Fret =  2,  Optional = false, }, -- 5
                    { String = 2,   Fret =  0,  Optional = false, }, -- R
                    { String = 3,   Fret =  3,  Optional = false, }, -- 7
                    { String = 4,   Fret =  1,  Optional = false, }, -- 3
                },

                ['3'] = {
                    { String = 1,   Fret =  2,  Optional = false, }, -- 7
                    { String = 2,   Fret =  0,  Optional = false, }, -- 3
                    { String = 3,   Fret =  0,  Optional = false, }, -- R
                    { String = 4,   Fret =  0,  Optional = false, }, -- 5
                },

                ['4'] = {
                    { String = 1,   Fret =  2,  Optional = false, }, -- 3
                    { String = 2,   Fret =  2,  Optional = false, }, -- 7
                    { String = 3,   Fret =  2,  Optional = false, }, -- 5
                    { String = 4,   Fret =  0,  Optional = false, }, -- R
                },

            },

            Min7 = {

                ['1'] = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- R
                    { String = 2,   Fret =  0,  Optional = false, }, -- 5
                    { String = 3,   Fret =  0,  Optional = false, }, -- b3
                    { String = 4,   Fret =  0,  Optional = false, }, -- b7
                },

                ['2'] = {
                    { String = 1,   Fret =  2,  Optional = false, }, -- 5
                    { String = 2,   Fret =  0,  Optional = false, }, -- R
                    { String = 3,   Fret =  2,  Optional = false, }, -- b7
                    { String = 4,   Fret =  0,  Optional = false, }, -- b3
                },

                ['3'] = {
                    { String = 1,   Fret =  1,  Optional = false, }, -- b7
                    { String = 2,   Fret = -1,  Optional = false, }, -- b3
                    { String = 3,   Fret =  0,  Optional = false, }, -- R
                    { String = 4,   Fret =  0,  Optional = false, }, -- 5
                },

                ['4'] = {
                    { String = 1,   Fret =  1,  Optional = false, }, -- b3
                    { String = 2,   Fret =  1,  Optional = false, }, -- b7
                    { String = 3,   Fret =  2,  Optional = false, }, -- 5
                    { String = 4,   Fret =  0,  Optional = false, }, -- R
                },

            },

            MinMaj7 = {

                ['1'] = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- R
                    { String = 2,   Fret =  0,  Optional = false, }, -- 5
                    { String = 3,   Fret =  0,  Optional = false, }, -- b3
                    { String = 4,   Fret =  1,  Optional = false, }, -- 7
                },

                ['2'] = {
                    { String = 1,   Fret =  2,  Optional = false, }, -- 5
                    { String = 2,   Fret =  0,  Optional = false, }, -- R
                    { String = 3,   Fret =  3,  Optional = false, }, -- 7
                    { String = 4,   Fret =  0,  Optional = false, }, -- b3
                },

                ['3'] = {
                    { String = 1,   Fret =  2,  Optional = false, }, -- 7
                    { String = 2,   Fret = -1,  Optional = false, }, -- b3
                    { String = 3,   Fret =  0,  Optional = false, }, -- R
                    { String = 4,   Fret =  0,  Optional = false, }, -- 5
                },

                ['4'] = {
                    { String = 1,   Fret =  1,  Optional = false, }, -- b3
                    { String = 2,   Fret =  2,  Optional = false, }, -- 7
                    { String = 3,   Fret =  2,  Optional = false, }, -- 5
                    { String = 4,   Fret =  0,  Optional = false, }, -- R
                },

            },

            ['7'] = {
                ['1'] = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- R
                    { String = 2,   Fret =  0,  Optional = false, }, -- 5
                    { String = 3,   Fret =  1,  Optional = false, }, -- 3
                    { String = 4,   Fret =  0,  Optional = false, }, -- b7
                },

                ['2'] = {
                    { String = 1,   Fret =  2,  Optional = false, }, -- 5
                    { String = 2,   Fret =  0,  Optional = false, }, -- R
                    { String = 3,   Fret =  2,  Optional = false, }, -- b7
                    { String = 4,   Fret =  1,  Optional = false, }, -- 3
                },
                ['3'] = {
                    { String = 1,   Fret =  1,  Optional = false, }, -- b7
                    { String = 2,   Fret =  0,  Optional = false, }, -- 3
                    { String = 3,   Fret =  0,  Optional = false, }, -- R
                    { String = 4,   Fret =  0,  Optional = false, }, -- 5
                },
                ['4'] = {
                    { String = 1,   Fret =  2,  Optional = false, }, -- 3
                    { String = 2,   Fret =  1,  Optional = false, }, -- b7
                    { String = 3,   Fret =  2,  Optional = false, }, -- 5
                    { String = 4,   Fret =  0,  Optional = false, }, -- R
                },

            },

            Dim7 = {

                ['1'] = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- R
                    { String = 2,   Fret = -1,  Optional = false, }, -- b5
                    { String = 3,   Fret =  0,  Optional = false, }, -- b3
                    { String = 4,   Fret = -1,  Optional = false, }, -- bb7
                },

                ['2'] = {
                    { String = 1,   Fret =  1,  Optional = false, }, -- b5
                    { String = 2,   Fret =  0,  Optional = false, }, -- R
                    { String = 3,   Fret =  1,  Optional = false, }, -- bb7
                    { String = 4,   Fret =  0,  Optional = false, }, -- b3
                },

                ['3'] = {
                    { String = 1,   Fret =  0,  Optional = false, }, -- bb7
                    { String = 2,   Fret = -1,  Optional = false, }, -- b3
                    { String = 3,   Fret =  0,  Optional = false, }, -- R
                    { String = 4,   Fret = -1,  Optional = false, }, -- b5
                },

                ['4'] = {
                    { String = 1,   Fret =  1,  Optional = false, }, -- b3
                    { String = 2,   Fret =  0,  Optional = false, }, -- bb7
                    { String = 3,   Fret =  1,  Optional = false, }, -- b5
                    { String = 4,   Fret =  0,  Optional = false, }, -- R
                },

            },

        },    },------------------------------------------------------------------------------------------------------------------------
-- Functions    GetChordDef = function (self, ChordFamily, ChordType, ChordForm)

--[[
    ChordDef = ChordDefs:GetChordDef ('Maj', 'E');

    Returns a table with this structure:

        {
            ChordForm = "E",
            ChordRoot = { 6, 0, },
            { String = 1,   Fret = 0,   Optional = false, },
            { String = 2,   Fret = 0,   Optional = false, },
            { String = 3,   Fret = 1,   Optional = false, },
            { String = 4,   Fret = 2,   Optional = false, },
            { String = 5,   Fret = 2,   Optional = false, },
            { String = 6,   Fret = 0,   Optional = false, },
        }
--]]
--reaper.ShowMessageBox (DataDumper (self.ChordFormDefs[ChordFamily][ChordType]), 'self.ChordFormDefs[ChordFamily][ChordType]', 0);

        local ChordDef = self.ChordFormDefs[ChordFamily][ChordType][ChordForm];

        ChordDef.ChordForm = ChordForm;
        ChordDef.ChordRoot = self.ChordFormRoots[ChordForm];

        return ChordDef;

    end, -- function GetChordDef

------------------------------------------------------------------------------------------------------------------------

    GetChordNotes = function (self, ChordFamily, ChordType, ChordForm, PitchCursor, Strings, IncludeOptionalNotes)

--[[
    ChordNotes = ChordDefs:GetChordNotes ('Maj', 'E');

    Returns a table with this structure:

        {
            Notes = {
                {5, 40},    -- Channel (0 = Channel 1), Note Number (60 = Middle C)
                {4, 47},
                {3, 52},
                {2, 56},
                {1, 59},
                {0, 64},
            },
        }
--]]

        local ChordDef = self:GetChordDef (ChordFamily, ChordType, ChordForm);

--reaper.ShowMessageBox (DataDumper (ChordDef), 'DataDumper (ChordDef)', 0);

        local RootString, RootFret = table.unpack (ChordDef.ChordRoot);

        local RootNote = RootFret + self.StringDefs[RootString].OpenNote;

        local PitchDelta = PitchCursor - RootNote;--reaper.ShowMessageBox (DataDumper ({RootString, RootFret, RootNote, PitchCursor, PitchDelta}), 'DataDumper ({RootString, RootFret, RootNote, PitchCursor, PitchDelta})', 0);

        local ChordNotes = {};
        local DroppedNotes = false;

        for ChordNote = 1, #ChordDef do
            local String  = ChordDef[ChordNote].String;
            local Fret    = ChordDef[ChordNote].Fret;
            local Channel = self.StringDefs[String].Channel;
            local Note    = self.StringDefs[String].OpenNote + Fret + PitchDelta;
--[[
    Only insert a note if:
        * The string is selected
        * The note is not optional, or optional notes are to be included
        * The note is not below fret 0 (warn if this happens)--]]            if (Strings[String]) and (not (ChordDef[ChordNote].Optional) or IncludeOptionalNotes) then
                if (Fret + PitchDelta < 0) then
                    DroppedNotes = true;
                else
                    ChordNotes[#ChordNotes + 1] = { Channel, Note, };
                end
            end

        end
        if DroppedNotes then
            reaper.ShowMessageBox ('Some notes of the chord were dropped because they were out of range.\nCheck that the root note agrees with the chord form.', 'Warning: Dropped Notes', 0);
        end
        return ChordNotes

    end, -- function GetChordNotes

------------------------------------------------------------------------------------------------------------------------

    PrintChordTab = function (self, MaxChordTypesPerRow)

    if MaxChordTypesPerRow == nil then
        MaxChordTypesPerRow = math.huge;
    end

        local ChordDefText = '';

        for iChordFamily, tChordFamily in ipairs (self.ChordFamilies) do

            local ChordFormNames = { 'E', 'A', 'D', 'G', 'C', };

            if tChordFamily.Name == 'Inversions' then
                ChordFormNames = { '1', '2', '3', '4', }
            end

            for iChordGroup, tChordGroup in ipairs (tChordFamily) do

                local ChordNameLine  = '';
                local ChordFormLine  = '';
                local ChordFretLines = { '', '', '', '', '', '', };

                local ChordNameLength = #ChordFormNames * 4 + 5; -- 4 characters for each chord form + 5 spaces between chord types

                for iChordType, ChordType in ipairs (tChordGroup) do

                    if #ChordType > ChordNameLength then
                        ChordNameLength = #ChordType
                    end

                end

                for iChordType, ChordType in ipairs (tChordGroup) do

                    -- if it is the first chord in the row, then initialize all of the lines                    if iChordType % MaxChordTypesPerRow == 1 then
                        ChordDefText = ChordDefText .. ' ' .. tChordFamily.Name .. '\n';    -- add a leading space for alignment

                        ChordNameLine  = '';
                        ChordFormLine  = '';
                        ChordFretLines = { '', '', '', '', '', '', };
                    end

                    local tChordType = self.ChordFormDefs[tChordFamily.Name][ChordType]
                        ChordNameLine = ChordNameLine .. string.format (' %-' .. ChordNameLength - 1 .. 's', ChordType);    -- subtract 1, because of the leading alignment space

                    if tChordType ~= nil then

                        for iChordForm, ChordForm in ipairs (ChordFormNames) do

                            if tChordType[ChordForm] ~= nil then

                                local tChordForm = tChordType[ChordForm];

                                if #tChordForm > 0 then

                                    ChordFormLine = ChordFormLine .. string.format ("%2s  ", ChordForm);

                                    -- We can't be guaranteed that the items in tChordForm will be ordered from strings 1-6 (although they should be),
                                    -- so build a table that uses the string number as the key, and then iterate over strings 1-6.

                                    local FretsByString = {};

                                    for iStringDef, tStringDefs in ipairs (tChordForm) do

                                        local String = tStringDefs.String;

                                        FretsByString[tStringDefs.String] = string.format ("%2d  ", tStringDefs.Fret);

                                    end

                                    for iString = 1, 6 do

                                        if FretsByString[iString] == nil then
                                            FretsByString[iString] = ' -  ';    -- could use ' X  ', but I think ' -  ' makes it stand out more
                                        end

                                        ChordFretLines[iString] = ChordFretLines[iString] .. FretsByString[iString];

                                    end

                                else

                                    ChordFormLine = ChordFormLine .. string.format ('%4s', '');

                                    for iString = 1, 6 do
                                        ChordFretLines[iString] = ChordFretLines[iString] .. string.format ('%4s', '');
                                    end

                                end

                            else

                                ChordFormLine = ChordFormLine .. string.format ('%4s', '');

                                for iString = 1, 6 do
                                    ChordFretLines[iString] = ChordFretLines[iString] .. string.format ('%4s', '');
                                end

                            end

                        end

                        ChordFormLine = ChordFormLine .. string.format ('%5s', '');

                        for iString = 1, 6 do
                            ChordFretLines[iString] = ChordFretLines[iString] .. string.format ('%5s', '');
                        end

                    else

                        ChordFormLine = ChordFormLine .. string.format ('%' .. ChordNameLength .. 's', '');

                        for iString = 1, 6 do
                            ChordFretLines[iString] = ChordFretLines[iString] .. string.format ('%' .. ChordNameLength .. 's', '');
                        end

                    end

                    -- if it is the last chord in the row or the last chord in the family group, then print the lines
                    if (iChordType % MaxChordTypesPerRow == 0) or (iChordType == #tChordGroup) then

                        ChordDefText = ChordDefText .. ChordNameLine .. '\n';
                        ChordDefText = ChordDefText .. ChordFormLine .. '\n';

                        for iString = 1, 6 do
                            ChordDefText = ChordDefText .. ChordFretLines[iString] .. "\n";
                        end

                        ChordDefText = ChordDefText .. '\n';

                    end

                end

            end

        end

        return ChordDefText;

    end, -- function PrintChordTab

------------------------------------------------------------------------------------------------------------------------

    GetChordList = function (self)

        local ChordList = {};        -- First, get the number of chords, so that we can create a MIDI item with the correct size

        for iChordFamily, tChordFamily in ipairs (self.ChordFamilies) do

            local ChordFormNames = { 'E', 'A', 'D', 'G', 'C', };

            if tChordFamily.Name == 'Inversions' then
                ChordFormNames = { '1', '2', '3', '4', }
            end

            for iChordGroup, tChordGroup in ipairs (tChordFamily) do

                for iChordType, ChordType in ipairs (tChordGroup) do

                    local tChordType = self.ChordFormDefs[tChordFamily.Name][ChordType]

                    if tChordType ~= nil then

                        for iChordForm, ChordForm in ipairs (ChordFormNames) do

                            if tChordType[ChordForm] ~= nil then

                                local tChordForm = tChordType[ChordForm];

                                if #tChordForm > 0 then
                                    ChordList[#ChordList + 1] = { tChordFamily.Name, ChordType, ChordForm, };

                                end

                            end

                        end
                    end

                end

            end

        end
    return ChordList;

    end, -- function GetChordList

------------------------------------------------------------------------------------------------------------------------

};
------------------------------------------------------------------------------------------------------------------------