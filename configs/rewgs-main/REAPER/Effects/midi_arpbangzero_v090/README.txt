arp!0 - groovy midi arpeggiator
___
0.90rc - 1 jan 2014
- move the in_pin:/out_pin: lines above @init for Reaper 4.59pre4+
0.89rc - 12 june 2012 - not so fast release
- fix variant dir seq logic broken by prelim dir ui remapping code
0.88rc - 9 june 2012 - almost nearly semi-final thoughts and warnings release
- WARNING: in next release, presets saved w/ arp!0 v0.81beta and earlier
  will not load.
- WARNING: some obscure dirops have been removed or altered.  presets using
  the resortx meta, dir repeat and sequential section dirops will need to
  be manually updated.
- tweak opacity of dirop specific metas to match lighter dirops
- remove resortx meta functionality; replace with "%" resortx dirop
- remove dir repeat dirops; replace with prime/prime2 variants of the 4 
  "on-foo" dirops: on-foo+prime seeks to prior on-foo+prime2; will wrap 
  around to find following on-foo+prime2.
- move sequential section logic from variants of "?:" random section dirop
  to dedicated ",:" sequential section dirop which supports 3 independent
  section sequences.
- allow right-click on [arp!0] logo to show debug info
- a few semi-useful labeled debug infos, including last read preset version
- tweak a few dirop icons for clarity
- temporarily display preset version number
0.87rc - 31 may 2012 - it lives! mad science release
- experimental subdir dirop: alien dirop substitutes oneshot dir seq from next 
  variant. heart dirop immediately returns to invoking dir seq. alien dirop with
  prime/prime2 metas subs 2nd & 3rd next variants.  
- changed 4x section dirop to 3x section (:4 to 3:), and changed variant 
  values when combined with prime/prime2/section metas to enable musically 
  useful multiples of sequential sections.
- WARNING: in next release, presets saved w/ arp!0 v0.81beta and earlier
  will not load.
0.86rc - 28 may 2012 - forward into past release
- fix incompatibility w/ pre-bugfixed Js
- add on host seek dirop: jump to dirop when host seeks
- change subtract/contract metas to prime2/prime (''/') for dirops
- prime/prime2 metas for larger weights in :x4 dirop and remove :x16 dirop
- prime/prime2 metas for sequential sections variants of ?: random section dirop
0.85rc - 24 may 2012 - back to future release
- fix ctl3/4 sequence length bug
- fix left click in tick slider bug
- add true double-click logic to dropdown buttongrid
- fix bug in send midi cc for dir seq edits
- fix bug: don't always send extended midi cc on chans 1-5
- prevent extended midi cc out when arp!0 chan + extended cc chan offset > 16
- fix inverted midi cc do pos reset & save var edits logic
- new default color scheme: clarity
- reorganized & tweaked color schemes; removed a few that seemed redundant
- add left/right-click on "swing" label to go to next/prev color scheme
- documentation updates/edits
- bump max default colors to 32
___
see arpbangzero_documentation.pdf in the release zip for a complete 
quick reference and very important credits.  see arpbangzero_changes.txt
for full release notes.
___
installation: the arp!0 zip file will unzip into something like this:

    midi_arpbangzero_v000/
      midi_arpbangzero
      README.txt
      arpbangzero_documentation.pdf
      arpbangzero_changes.txt
      gpl.txt
      bangzero_files/
        <lots o' bits>
      bangzero_data/
        arpbangzero_settings.txt
        arpbangzero_defcolors.txt
        arpbangzero_sortx.txt
        arpbangzero_defsortx.txt
              
  after unzipping, select "Show REAPER resource path in explorer/finder..."
  from the Reaper Options menu to open the Reaper resources folder.  in that
  folder there will be an Effects subfolder for Jesusonic fx plugins, and a
  Data folder.  copy the midi_arpbangzero Js script file and the
  bangzero_files folder into the Effects folder.  for new installations, 
  copy the bangzero_data folder into the Data folder.  
  
  after installation you should have something like this:
  
    <Reaper resources folder>/
      Effects/
        midi_arpbangzero
        bangzero_files/
          <lots o' bits>
      Data/
        bangzero_data/
          arpbangzero_settings.txt
          arpbangzero_defcolors.txt
          arpbangzero_sortx.txt
          arpbangzero_defsortx.txt
            
  when updating, replace midi_arpbangzero and bangzero_files in the Effects
  folder.  if there are significant changes to the global settings or sort
  transforms i will note this at the top of this README.txt file. in that
  case, if you have customized the global settings or sort transforms, you
  will need to merge your changes with the files in the bangzero_data
  folder.  this includes the arpbangzero_settings.txt global settings file
  and the arpbangzero_sortx.txt sort transforms file.
___
feedback welcome: bang at forum.cockos.com - email: bang at bangzero dot org
___
credits: 

  first and formost, highest praise and thanks to Justin Frankel and 
  the Cockos team for Jesusonic, the audio/midi hacker's paradise.  it is
  *so* cool to be able to create & customize fx plugins that integrate
  with the Reaper ecosystem.  heya! hey!
  
  arp!0 was largely inspired by the arpeggiator in Urs Heckmann's amazing
  Zebra2 software synthesizer, <http://www.u-he.com/cms/zebra>, and by the 
  many cool arp presets available for Zebra.  in addition to the powerful 
  step and voices options, the way the entire Zebra arp is visible and 
  accessible makes it exceptionally *useable*.  i wanted this useability 
  with other softsynths, and also the option to record and postprocess arp 
  output.
  
  i have wanted the groovy accent and offset features for a long time.  
  seeing these realized in Arto Vaarala's Kirnu arp was inspiring.  Kirnu 
  has many unique capabilities of its own: 
  <http://www.artovaarala.com/index.html>.
  
  the arp!0 user interface mostly grew out of the natural possibilities of
  the Jesusonic graphics api.  but a major inspiration for the clean, flat
  look are Sean Costello's beautiful interfaces for his awesome ValhallaDSP 
  fx: <http://www.valhalladsp.com/>.
  
  a quick heyah! to sound design craftsman Michael Cavallo, who's marvelously
  mutable mc Percaluptus Zebra preset was good company as i developed
  arp!0.  Michael's Zebra soundbanks are great, and his arp patches are 
  especially luminous: <http://www.monomo-sounddesign.com/>.
  
  finally, all praise and honor to Baba O'Riley and all the rhythmic synth
  pioneers.  we stand on the shoulders of giants in this teenage wasteland.
___
copyright 2014 dan mcmullen bang@bangzero.org

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>. 

