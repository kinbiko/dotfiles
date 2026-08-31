# Ergodox online configurations and comments

This is a list of all my Ergodox configurations as they are online.
Unfortunately, simply storing the config isn't enough to modify it later on.

### Remember:

<!-- TODO: Is this still true? -->

- When selecting `"` in the online utility, because of my keyboard mapping this will actually be `@`
- "non-US `\`" is actually `` ` ``.
- `` ` `` is actually `\`
- `\` is actually `#`

Maybe it's easier to switch to a US English keyboard layout?

### Structure

The heading of each of the below sections links to the corresponding version of my Ergodox config.

Below the heading are some frustrations with the current layout and ideas for the next version.

## [Version 1](https://configure.ergodox-ez.com/ergodox-ez/layouts/gaAw4/latest/1)

- Get rid of numbers along the top entirely. I rarely hit the right one, and it's probably easier for me to hit two modes to get it into a mode where the numpad becomes available. Then I won't be as tempted to use the top row for programming buttons like `!"\$%^&\*()\_+=-` etc.
- Make layer 1 + caps lock do backspace.
- Add mouse button clicks
- The lights doesn't appear to work with this one. I think I chose glow, which might not match what my keyboard is capable of.
- Caps lock becomes CTRL when held or escape when not held
- big button []{} goes away in favour of second layer
- left 'enter' is layer 2
- Clean up weird stuff in layer 0

## [Version 2](https://configure.ergodox-ez.com/ergodox-ez/layouts/XbMwy/latest/2)

- This layout has no way of doing minus or equals

## [Version 3](https://configure.ergodox-ez.com/ergodox-ez/layouts/40E5n/latest/1)

- This layout has no way of hitting plus and underscore.
- Need to be able to turn off the colours, so it's not distracting to other people.

## [Version 4](https://configure.ergodox-ez.com/ergodox-ez/layouts/Rjr55/latest/0)

- No way of toggling or weakening the colours between layers.

## [Version 5](https://configure.ergodox-ez.com/ergodox-ez/layouts/JaQLB/latest/2)

- Need to remap "Go to definition" and "Pop" in vim or make `[]` easier to hit in combination with space
- Touch time for tap vs. press is far too short
- Would be good to have quotes on the bottom left row, then brackets above that, the funky symbols above that again.
- Make layer 1 arrow keys be `hjkl`. Mouse clicks can be the remaining thumb button on the left.
- Switch `&` and `*`

## [Version 6](https://configure.ergodox-ez.com/ergodox-ez/layouts/9DKbW/latest/1)

- `CTRL + ESC` thing is still a bit awkward when trying to quickly `CTRL+a` in TMUX for instance. Might be best to only have it as CTRL.
- Having `@` and `~` right next to each other can lead to awkward executions of a register when I want to change the capitalisation of a character in vim
- It's a bit awkward reaching the most common numbers right now. Consider moving numbers to half above the `hjkl` keys and half below.
- Also, let's make the number rows `01234`, `56789` as `1` and `0` are used together a lot.
- Need to get `^` back to an easier position to hit.

## [Version 7](https://configure.ergodox-ez.com/ergodox-ez/layouts/bv5gg/latest/0)

- Add red/green/refactor backlight buttons
- Make `` ` `` and `\` easier to reach. Maybe instead of `-` and `=` on the big keys on the LHS which I never use.

## [Version 8](https://configure.ergodox-ez.com/ergodox-ez/layouts/x9Jqo/latest/0)

- Make hitting `ctrl+tab` easier
- Left 'enter' key is never used.
- Make layer 1 caps lock be ESC
- Re-map the RHS bottom row arrow keys to something more useful, as I keep using layer 1 + `hjkl` anyway for arrows
  - mouse movement
- expose `F1-F12` keys

## [Version 9](https://configure.ergodox-ez.com/ergodox-ez/layouts/Jwj5m/latest/1)

- Re-enable modifier keys in other levels so that the order in which modifier keys and layer shifting keys are hit doesn't matter.
- Set up a layer change button on both sides of the keyboard so that using the mouse movement keys becomes one-handed if necessary.
- Set up a Windows gaming layer.

## [Version 10](https://configure.ergodox-ez.com/ergodox-ez/layouts/53oKe/latest/3)

- Re-enable modifier keys in other levels so that the order in which modifier keys and layer shifting keys are hit doesn't matter.
- Set up a layer change button on both sides of the keyboard so that using the mouse movement keys becomes one-handed if necessary.
- Make the mouse more usable by tweaking the advanced mouse config settings. Ideally, consistent movement without inertia, but perhaps a bit faster.
- Replace the windows layer with an excalidraw layer instead.

## [Version 11](https://configure.zsa.io/ergodox-ez/layouts/ZDnb5/latest/0)

- Make mouse movements more precise, remove unused layer and some keys.

## [Version 12](https://configure.zsa.io/ergodox-ez/layouts/A0r90/latest/0)

- [x] Scroll speed is way too fast, after some initial very slowness.
- [x] Can't hit any of the Anki answer keys (`1234`) with my left hand, which makes it awkward when I'm using a pen in my right hand. I should probably solve this with an Anki plugin though.
- [x] Make layer 1 (symbols)'s "caps lock" be `ctrl+alt`, so I can use this for yabai window management.
- [x] `[]{}()` could be `[{(]})` instead? (`close - open = 3` always for easy muscle memory)

## [Version 13](https://configure.zsa.io/ergodox-ez/layouts/oyvow/latest/1)

- [x] Make max mouse scroll speed faster.

## [Version 14]()

- [x] Fix broken ctrl key

## [Version 15](https://configure.zsa.io/ergodox-ez/layouts/M4BLo/latest/0)

- Consider moving some of the "related" symbol keys further apart, so I experience fewer off-by-1 errors in my left hand. E.g.
  - [ ] `&` and `*`
  - [ ] `\` and `|`
  - [ ] `$` and `%` -- They're not really related, but I always hit the wrong one
