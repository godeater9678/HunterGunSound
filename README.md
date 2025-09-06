# HunterGunSound

World of Warcraft Hunter addon that adds custom gun sound effects and kill streak announcements.

## Features

- Custom gun sound effects for different weapons
- Kill Command sound replacements
- Enhanced audio feedback system
- Bow and crossbow sound enhancements
- Pet kill command audio cues

## Installation

1. Download or clone this repository
2. Place the `HunterGunSound` folder in your `World of Warcraft\_retail_\Interface\AddOns\` directory
3. Restart World of Warcraft or reload UI with `/reload`
4. Enable the addon in the AddOns menu

## Included Sounds

- Blunderbuss weapon fire and reload sounds
- Bow pullback and release sounds  
- Crossbow load and shoot sounds
- Pistol shot sounds
- Kill Command cast sounds
- Enhanced combat audio feedback
- Animal kill command sounds (bird, cat, snow leopard)

## Files

- `HunterGunSound.lua` - Main addon logic
- `HunterGunSound.toc` - Addon metadata
- Various `.ogg` sound files with different volume variants (min, normal, max)
- `handgun.tga` - Addon icon
- `SOUND_LICENSES.txt` - Sound assets licensing information

## Sound Assets

All sound files are sourced from **Mixkit.co** under the Mixkit Free License:
- ✅ Royalty-free for commercial and non-commercial use
- ✅ No attribution required
- ✅ CurseForge compliant

For detailed licensing information, see `SOUND_LICENSES.txt`.

## Compatibility

This addon is designed for World of Warcraft Retail (current expansion).

## Technical Notes

This addon uses the same sound file referencing method as other established WoW sound addons (e.g., OldGunSound). The approach is:
- References game sound IDs for replacement (standard practice)
- Uses only licensed sound assets (Mixkit.co)
- Includes AI-generated icon (no copyright issues)
- Fully compliant with CurseForge content policies

## Author

Created for enhanced Hunter gameplay experience with immersive sound effects.
