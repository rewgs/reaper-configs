--[[
    TODO
        * Finish populating/verifying the chord definitions--]]local Info       = debug.getinfo (1, 'S');
local ScriptPath = Info.source:match[[^@?(.*[\/])[^\/]-$]];
--local DebugFile  = assert (io.open (ScriptPath .. 'debug.txt', 'w'));
package.path     = ScriptPath .. '../lib/lua/?.lua;' .. package.path;

require ('strict');
require ('DataDumper');
--io.output (DebugFile);

                   dofile (ScriptPath .. '../lib/lua/lunker math.lua');
local ReaperFunc = dofile (ScriptPath .. '../lib/lua/lunker reaper.lua');
local GUI        = dofile (ScriptPath .. '../lib/lua/lokasenna gui beta8.lua');
local ChordDefs  = dofile (ScriptPath .. 'ChordDefs.lua');

------------------------------------------------------------------------------------------------------------------------
--[[
    Moved Lokasenna's GUI code from here into a separate file (and loaded it above),
    so that I don't get confused which part of this program is mine, and which part is his.
--]]
------------------------------------------------------------------------------------------------------------------------



--[[
    Draw the main window.
--]]

GUI.name = "MIDI Guitar Chord Tool";
GUI.x, GUI.y, GUI.w, GUI.h = 600, 200, 570, 500;

-- Global value for the divider line so everything else can reference from it
local line_x = 0
local line_y = 22

    ---- GUI Elements ----


dir   = "h";
thick = 0;

------------------------------------------------------------------------------------------------------------------------

GUI.elms = {

    ---- Global ----

--    tabs = GUI.Tabframe:new  (19, 0, 0, 64, line_y, '', 'Chord,Strum,Scales,Help', 8),
    tabs = GUI.Tabframe:new  (19, 0, 0, 64, line_y, '', 'Chord,Strum,', 8),
-- tab 1 : "Chord"

    ChordFormRadio        = GUI.Radio:new     (9,  line_x +  10, line_y + 30,  120, 150, 'Chord Form',     'E,A,D,G,C',        0),
    StringsChecklist      = GUI.Checklist:new (9,  line_x +  20, line_y + 200, 120, 300, 'Use Strings',    '1,2,3,4,5,6', 'v', 0),
    OptionalNotesRadio    = GUI.Radio:new     (9,  line_x +  10, line_y + 340, 120,  75, 'Optional Notes', 'Include,Exclude',  0),
    InversionsFrame       = GUI.Frame:new     (10, line_x + 320, line_y + 245, 240, 210, true, false),
--    InversionRadio        = GUI.Radio:new     (9,  line_x + 330, line_y + 250,  60, 145, 'Root\nString',   '1,2,3,4',          0),
    InversionRadio        = GUI.Radio:new     (9,  line_x + 330, line_y + 275,  60, 145, 'Root\nString',   '1,2,3,4',          0),
-- tab 2 : "Strum"
    StrumRandomnessRadio  = GUI.Radio:new     (7,  line_x + 10,  line_y +  30, 120, 75, 'Add Randomness',  'Yes,No',           0),
    StrumRandomnessSlider = GUI.Slider:new    (7,  line_x + 150, line_y +  60, 200,     '% Randomness (sd)', 0, 50, 50, 10, 'h'),

-- tab 3 : "Scales"

-- tab 4 : "Help"

};
------------------------------------------------------------------------------------------------------------------------
--[=[local MidiEditor, MidiTake, MidiTakeName = ReaperFunc.GetMidiEditor ();

--[[
      An active MIDI Editor is required to run this action.
      If one isn't available, exit with an error message.
--]]

if (not (MidiEditor)) then
    reaper.ShowMessageBox ('You must have an open MIDI Editor to run this tool.', 'Error: No MIDI Editor', 0);
    do return end
end

io.write (string.format ("MidiEditor       = %s\n", tostring (MidiEditor)));
io.write (string.format ("MidiTake         = %s\n", tostring (MidiTake)));
io.write (string.format ("MidiTakeName     = %s\n", MidiTakeName));
io.write ("\n");
--]=]
------------------------------------------------------------------------------------------------------------------------
function AddMidiChords (MidiTake, ChordFamily, ChordType, ChordForm, IncludeOptionalNotes, Strings)

--[[
    ChordDef = {
        ChordRoot = { 6, 0, },
        { String = 1,   Fret = 0,   Optional = false, },
        { String = 2,   Fret = 0,   Optional = false, },
        { String = 3,   Fret = 1,   Optional = false, },
        { String = 4,   Fret = 2,   Optional = false, },
        { String = 5,   Fret = 2,   Optional = false, },
        { String = 6,   Fret = 0,   Optional = false, },
    };

    Chord = {
        Notes = {
            {5, 40}, -- Channel (0 = Channel 1), Note Number
            {4, 47},
            {3, 52},
            {2, 56},
            {1, 59},
            {0, 64},
        },
    };
--]]    local MidiNotes = ReaperFunc.GetSelectedMidiNotes (MidiTake);
    if #MidiNotes == 0 then
        return;
    end    ReaperFunc.DeleteSelectedMidiNotes (MidiTake);

    for iMidiNote = 1, #MidiNotes do

        local MidiNote = MidiNotes[iMidiNote];        local _, MidiNotePropList = MidiNote:Get ();
        local Selected, Muted, Start, End, Channel, NoteNumber, Velocity = table.unpack (MidiNotePropList);

        local Notes = ChordDefs:GetChordNotes (ChordFamily, ChordType, ChordForm, NoteNumber, Strings, IncludeOptionalNotes);

        if #Notes < 1 then

            reaper.ShowMessageBox ('No notes were returned!\nCheck your settings for strings and optional notes.', 'Warning: No Notes', 0);

            return;

        end

        for Note = 1, #Notes do
            local Channel, NoteNumber = table.unpack (Notes[Note]);

io.write (string.format ("Note Sequence    = %d\n", Note));
io.write (string.format ("Chord Start PPQ  = %d\n", Start));
io.write (string.format ("Chord End   PPQ  = %d\n", End));
io.write (string.format ("Channel (Base 0) = %d\n", Channel));
io.write (string.format ("Note Number      = %d\n", NoteNumber));
io.write (string.format ("Note Velocity    = %d\n", Velocity));
io.write ("\n");

            MidiNote:Copy ({Channel = Channel, NoteNumber = NoteNumber, }, true);

        end

    end

    reaper.MIDI_Sort (MidiTake);
end -- function AddMidiChords

------------------------------------------------------------------------------------------------------------------------

function ChordButtonClick (ChordFamily, ChordType)    local MidiEditor, MidiTake, MidiTakeName = ReaperFunc.GetMidiEditor ();

--[[
      An active MIDI Editor is required to run this action.
      If one isn't available, exit with an error message.
--]]

    if (not (MidiEditor)) then
        reaper.ShowMessageBox ('You must have an open MIDI Editor to run this tool.', 'Error: No MIDI Editor', 0);
        do return end
    end

io.write ("ChordButtonClick\n");
io.write (string.format ("MidiEditor       = %s\n", tostring (MidiEditor)));
io.write (string.format ("MidiTake         = %s\n", tostring (MidiTake)));
io.write (string.format ("MidiTakeName     = %s\n", MidiTakeName));
io.write ("\n");

    local ChordFormLookupTable     = { 'E', 'A', 'D', 'G', 'C', };
    local OptionalNotesLookupTable = { true, false, };

    local ChordForm                = ChordFormLookupTable[GUI.elms.ChordFormRadio.retval];
    local IncludeOptionalNotes     = OptionalNotesLookupTable[GUI.elms.OptionalNotesRadio.retval];
    local Strings                  = GUI.elms.StringsChecklist.retval;

    if ChordFamily == 'Inversions' then
        ChordForm = tostring (GUI.elms.InversionRadio.retval);
    else
        ChordForm = ChordFormLookupTable[GUI.elms.ChordFormRadio.retval];
    end

    if (ChordDefs.ChordFormDefs[ChordFamily][ChordType] == nil) or (ChordDefs.ChordFormDefs[ChordFamily][ChordType][ChordForm] == nil) then

        reaper.ShowMessageBox (
            'The ' .. ChordForm .. ' form of the ' .. ChordType .. ' chord was not found in "ChordDefs.lua".\nFeel free to add a definition for this chord.',
            'Warning: Undefined Chord',
            0
        );

        return;

    end

    reaper.Undo_BeginBlock ();
    AddMidiChords (MidiTake, ChordFamily, ChordType, ChordForm, IncludeOptionalNotes, Strings);

    reaper.UpdateArrange ();    -- Update the arrangement (often needed)

    reaper.Undo_EndBlock ('Add MIDI Chord', 1);

--[[
    This can be unpredictable, depending on which windows have had recent focus.
    If I switch back-and-forth between the GUI and the MIDI Editor to select multiple notes,
    then only one window cycle is needed to focus on the MIDI Editor.
    If a note was already selected, and that is the only chord created,
    then cycling once will focus on the floating toolbar, not the MIDI Editor.
    Also, if focus isn't on the GUI, then I have to select it so that ESC will close it.
    So I think it is best to just leave the focus on the GUI.
--]]
--    ReaperFunc.RunCommand ('_S&M_WNFOCUS9'); -- first return focus to the floating toolbar,
--    ReaperFunc.RunCommand ('_S&M_WNFOCUS9'); -- and then to the MIDI Editor

end -- function ChordButtonClick

------------------------------------------------------------------------------------------------------------------------

function PrintChordTab ()    local ChordTabFile  = assert (io.open (ScriptPath .. 'ChordTabOut.txt', 'w'));

    io.output (ChordTabFile);

    io.write (ChordDefs:PrintChordTab(6));  -- maximum of 6 chord types per row

    ChordTabFile:close ();
end -- function PrintChordTab

------------------------------------------------------------------------------------------------------------------------

function CreateRegressionMidiItem ()--[[    TODO        It would be nice if this kept track of the min/max note per channel,
        so that I could see whether any chords go outside the range of the guitar.
        I know they don't go below the low range, because there are no warnings.
        But I would still like to optimize the root NoteNumber for better results.        However, this routine doesn't really have visibility into the note on each string -- just the root note.        I would need to post-process the MidiTake to tabulate the min/max for each channel/string
        local NoteLimits = {
            { Min = math.huge, Max = math.huge, }, -- 1st string
            { Min = math.huge, Max = math.huge, }, -- 2nd string
            { Min = math.huge, Max = math.huge, }, -- 3rd string
            { Min = math.huge, Max = math.huge, }, -- 4th string
            { Min = math.huge, Max = math.huge, }, -- 5th string
            { Min = math.huge, Max = math.huge, }, -- 6th string
        };--]]

    local ChordList = ChordDefs:GetChordList ();
    local ChordFamily = ChordList[1][1]; -- preset the chord family
    local ChordType   = ChordList[1][2]; -- and chord form

-- Make each note 3 QN long, with a QN pause after it,-- Add one measure between Chord Types, and an extra measure between Chord Families

    local EndQn = 8; -- QN=8 is the first QN of the third measure: [0,1,2,3], [4,5,6,7], etc. (using QN=8 gives a leading/trailing blank measure)
    for iChord = 1, #ChordList do

        if ChordList[iChord][1] ~= ChordFamily then
            EndQn       = EndQn + 4;            -- add a measure between chord families
            ChordFamily = ChordList[iChord][1]; -- and reset the chord family
        end

        if ChordList[iChord][2] ~= ChordType then
            EndQn     = EndQn + 4;            -- add a measure between chord types
            ChordType = ChordList[iChord][2]; -- and reset the chord type
        end

        local ChordForm = ChordList[iChord][3];

        EndQn = EndQn + 4; -- move to the next measure for the next chord form

    end

    local StartTime = 0;
    local EndTime   = reaper.TimeMap_QNToTime (EndQn);
--    local ReaperTrack = reaper.GetTrack                (0, 0);
    local ReaperTrack = reaper.GetSelectedTrack        (0, 0);
    local MidiItem    = reaper.CreateNewMIDIItemInProj (ReaperTrack, StartTime, EndTime, false);
    local MidiTake    = reaper.GetMediaItemTake        (MidiItem, reaper.GetMediaItemInfo_Value (MidiItem, 'I_CURTAKE'));

    local StartQn = 0; -- QN=0 is the first QN of the first measure: [0,1,2,3], [4,5,6,7], etc.
    ChordFamily = ChordList[1][1]; -- reset the chord family
    ChordType   = ChordList[1][2]; -- and chord form

    reaper.Undo_BeginBlock ();

    for iChord = 1, #ChordList do
        if ChordList[iChord][1] ~= ChordFamily then
            StartQn     = StartQn + 4;          -- add a measure between chord families
            ChordFamily = ChordList[iChord][1]; -- and reset the chord family
        end
        if ChordList[iChord][2] ~= ChordType then
            StartQn   = StartQn + 4;          -- add a measure between chord types
            ChordType = ChordList[iChord][2]; -- and reset the chord type
        end
        local ChordForm = ChordList[iChord][3];

        StartQn = StartQn + 4; -- move to the next measure for the next chord form
        local PpqStart = reaper.MIDI_GetPPQPosFromProjQN (MidiTake, StartQn);
        local PpqEnd   = reaper.MIDI_GetPPQPosFromProjQN (MidiTake, StartQn + 3);
        reaper.MIDI_InsertTextSysexEvt (MidiTake, false, false, PpqStart, 1, ChordFamily .. ' :: ' .. ChordType .. ' :: ' .. ChordForm);--[[
    I chose the root Note Numbers such that

      * Both the CAGED and the Inversions forms would use the same root note (F)

      * No notes are dropped from any of the chords
      * As best as possible, no notes go above the limit of each string--]]        local Channel    =  0;
--        local NoteNumber = 52;  -- E : 6th string, 12th fret
        local NoteNumber = 53;  -- F : 6th string, 13th fret
        local Velocity   = 96;

        if ChordFamily == 'Inversions' then
--            NoteNumber = 64;    -- E : 3rd string, 9th fret
            NoteNumber = 65;    -- F : 3rd string, 10th fret
        end

        reaper.MIDI_InsertNote (MidiTake, true, false, PpqStart, PpqEnd, Channel, NoteNumber, Velocity, false); -- YIKES!!!  If NoSort is set to true, it doesn't set the end time until they are sorted, which messes up the notes!        local ChordFamily, ChordType, ChordForm = table.unpack (ChordList[iChord]);        AddMidiChords (MidiTake, ChordFamily, ChordType, ChordForm, true, { true, true, true, true, true, true, });
        ReaperFunc.UnselectAllMidiNotes (MidiTake);

    end

    reaper.UpdateArrange ();    -- Update the arrangement (often needed)

    reaper.Undo_EndBlock ('Create MIDI Chord Regression Item', 0);

end -- function CreateRegressionMidiItem

------------------------------------------------------------------------------------------------------------------------

--[[
    Create the buttons for the different chord types.
    All of the buttons will use the same 'ChordButtonClick' function, and pass in the necessary parameters.
--]]

do -- this block is just to localize the scope of ChordRows
-- Add buttons for all except the 'Inversions' chords    local SaveChordFamilyCount;
    local ChordRows = 1;
    for ChordFamilyCount = 1, #ChordDefs.ChordFamilies do        local ChordFamily = ChordDefs.ChordFamilies[ChordFamilyCount].Name;
        if ChordFamily == 'Inversions' then  -- the 'Inversions' family of buttons gets created differently (see below)
            SaveChordFamilyCount = ChordFamilyCount;            break;
        end
        GUI.elms[ChordFamily] = GUI.Label:new(9, line_x + 80 + 80 * ChordRows, line_y + 20, ChordFamily, true, 1);

        for ChordGroupCount = 1, #ChordDefs.ChordFamilies[ChordFamilyCount] do
            for ChordCount = 1, #ChordDefs.ChordFamilies[ChordFamilyCount][ChordGroupCount] do

                local ChordType = ChordDefs.ChordFamilies[ChordFamilyCount][ChordGroupCount][ChordCount];

                GUI.elms[ChordType] = GUI.Button:new (9, line_x + 80 + 80 * ChordRows, line_y + 25 + 25 * ChordCount, 65, 20, ChordType, ChordButtonClick, ChordFamily, ChordType);

            end -- for ChordCount

            ChordRows = ChordRows + 1;

        end -- for ChordGroupCount

    end -- for ChordFamilyCount
-- Add buttons for the 'Inversions' chords
    local ChordFamily = 'Inversions'

    -- reset these values --    ChordRows        = 1;
    ChordFamilyCount = SaveChordFamilyCount;

    GUI.elms[ChordFamily] = GUI.Label:new(9, line_x + 80 + 80 * (ChordRows + 3), line_y + 245, ChordFamily, true, 1);

    for ChordGroupCount = 1, #ChordDefs.ChordFamilies[ChordFamilyCount] do

        for ChordCount = 1, #ChordDefs.ChordFamilies[ChordFamilyCount][ChordGroupCount] do

            local ChordType = ChordDefs.ChordFamilies[ChordFamilyCount][ChordGroupCount][ChordCount];

            GUI.elms['Inversions' .. ChordType] = GUI.Button:new (9, line_x + 80 + 80 * (ChordRows + 3), line_y + 25 + 25 * (ChordCount + 9), 65, 20, ChordType, ChordButtonClick, ChordFamily, ChordType);

        end -- for ChordCount

        ChordRows = ChordRows + 1;

    end -- for ChordGroupCount--[[    TODO -- Comment out these two buttons if I release this to other people--]]--    GUI.elms.PrintChordTab  = GUI.Button:new (9, line_x + 80 + 80, line_y + 25 + 15 * 25, 65, 20, 'Print Tab', PrintChordTab);
--    GUI.elms.CreateMidiItem = GUI.Button:new (9, line_x + 80 + 80, line_y + 25 + 16 * 25, 65, 20, 'Validate',  CreateRegressionMidiItem);
--]]end -- do------------------------------------------------------------------------------------------------------------------------

--[[
    Create the buttons for the different strum/arpeggio options.
    All of the buttons will use the same 'StrumArpeggioButtonClick' function, and pass in the necessary parameters.
--]]

local function StrumArpeggioButtonClick (StrumTime)

    local MidiEditor, MidiTake, MidiTakeName = ReaperFunc.GetMidiEditor ();

--[[
      An active MIDI Editor is required to run this action.
      If one isn't available, exit with an error message.
--]]

    if (not (MidiEditor)) then
        reaper.ShowMessageBox ('You must have an open MIDI Editor to run this tool.', 'Error: No MIDI Editor', 0);
        do return end
    end

io.write ("StrumArpeggioButtonClick\n");
io.write (string.format ("MidiEditor       = %s\n", tostring (MidiEditor)));
io.write (string.format ("MidiTake         = %s\n", tostring (MidiTake)));
io.write (string.format ("MidiTakeName     = %s\n", MidiTakeName));
io.write ("\n");

    local AddRandomnessLookupTable = { true, false, };
    local AddRandomness            = AddRandomnessLookupTable[GUI.elms.StrumRandomnessRadio.retval];
    local RandomnessSd             = GUI.elms.StrumRandomnessSlider.retval;
    if StrumTime == 'None' then
        StrumTime = 0;
    elseif StrumTime == 'Grid' then
        StrumTime = reaper.MIDI_GetGrid (MidiTake);
    end-- I'm not sure why, but somehow these undo blocks are not registering correctly.
-- When I undo them, it also undos the chord creation.    reaper.Undo_BeginBlock ();

    if StrumTime == 'Arp.' then
        ReaperFunc.ArpeggiateMidiNotes (MidiTake,            AddRandomness, RandomnessSd / 100); -- convert RandomnessSd from integer to %
    else
        ReaperFunc.StrumMidiNotes      (MidiTake, StrumTime, AddRandomness, RandomnessSd / 100); -- convert RandomnessSd from integer to %
    end

    reaper.UpdateArrange ();    -- Update the arrangement (often needed)

    reaper.Undo_EndBlock ('Strum MIDI Chord', 0);

end -- function StrumArpeggioButtonClick

------------------------------------------------------------------------------------------------------------------------

do -- this block is just to localize the scope of StrumLabels
    GUI.elms.None = GUI.Button:new (7,  line_x + 10, line_y + 150, 40, 20, 'None', StrumArpeggioButtonClick, 'None');

    local StrumLabels = { 64, 32, 16, 8, 4, 2, 1, };    for iStrumLabel = 1, #StrumLabels do
        local StrumLabel = StrumLabels[iStrumLabel];
        local StrumTime = 4 / StrumLabel;

        GUI.elms[StrumLabel] = GUI.Button:new (7,  line_x + 10 + 55 * iStrumLabel, line_y + 150, 40, 20, '1/' .. StrumLabel, StrumArpeggioButtonClick, StrumTime);

    end
    GUI.elms.Grid = GUI.Button:new (7,  line_x + 10 + 55 * (#StrumLabels + 1), line_y + 150, 40, 20, 'Grid', StrumArpeggioButtonClick, 'Grid');
    GUI.elms.Arp  = GUI.Button:new (7,  line_x + 10 + 55 * (#StrumLabels + 2), line_y + 150, 40, 20, 'Arp.', StrumArpeggioButtonClick, 'Arp.');

end
------------------------------------------------------------------------------------------------------------------------
-- Set the default parameters (if they are different from what the GUI selectes)

GUI.elms.StringsChecklist:val ( {true, true, true, true, true, true, } );
--GUI.elms.OptionalNotesRadio:val (2);



-- Use z = 18 to hide something, f.e. the "unable to preview" warning.
GUI.elms_hide = {[18] = true}

-- z-layers will be active for any set they're listed in
GUI.elms.tabs:update_sets(
    {
        [1] = {3, 4, 5, 6,        9, 10},
        [2] = {3, 4, 5, 6, 7, 8},
        [3] = {3, 4, 5, 6,                11, 12, 13},
        [4] = {   4, 5, 6,                             15, 16},
        [5] = {                                                 17},
    }
)

------------------------------------------------------------------------------------------------------------------------

    ---- Put all of your own functions and whatever here ----


    ---- Main loop ----

--[[

    If you want to run a function during the update loop, use the variable GUI.func prior to
    starting GUI.Main() loop:

    GUI.func = my_function
    GUI.freq = 5    <-- How often in seconds to run the function, so we can avoid clogging up the CPU.
                        - Will run once a second if no value is given.
                        - Integers only, 0 will run every time.

    GUI.Init()
    GUI.Main()

]]--
--GUI.func = Main
--GUI.freq = 0

GUI.Init();
GUI.Main();


--DebugFile:close ();
