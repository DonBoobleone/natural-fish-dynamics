# Natural Fish Dynamics - A Mod for Factorio

Fish breed on their own in their natural habitat.
On supported planets chunks can spawn fish if:
- There is at least 2 Fish
- There is enough water.

Fish will reproduce based on a normal distribution.
Highest chance of reproduction when water is half-full with fish.

## Supported Planets
- Nauvis
- Gleba - Check tips how to import fish on Gleba
- Aquilo - Fish import is also needed (Note: Won't work with mods that void items in ammonia ocean)
- Pelagos
- Lignumis
- Rabbasca

## Settings

All settings are runtime-global and can be changed in-game at any time.

- **Breeding Limit** – Maximum number of fish allowed per full-water chunk before overpopulation stops breeding (default 128, 16–512).
- **Breeding Cycle** – How frequently breeding attempts occur (default "normal"; options from "ultra-fast (×10)" to "ultra-slow (÷10)").
- **Breeding Chunk Scale Divisor** – Controls overall breeding frequency across the map. Lower values = faster fish population growth. Higher values = slower growth with lower UPS impact (default 1200).
- **Breeding Max Chunks Per Tick** – Maximum chunks the mod can check per tick per surface. Higher = faster breeding on very large maps but higher UPS usage. Lower = better performance (default 32).
- **Fish Litter Size** – Determines how many fish are born at once from a successful breeding (default 1, 1–16).
- **Enable Breeding on [Planet]** – One toggle per planet (Nauvis, Gleba, Aquilo, Pelagos, Lignumis, Rabbasca). All default to enabled.

Disabling breeding on a planet you don't plan to use fish on skips all breeding checks for that planet, saving UPS with no side effects.

## Tip
You can catch and release fish by dropping them in water with 'Z'
[Watch video](https://www.youtube.com/watch?v=rKjyyxmKQec)
[![Catch and Release Thumbnail](https://img.youtube.com/vi/rKjyyxmKQec/maxresdefault.jpg)](https://www.youtube.com/watch?v=rKjyyxmKQec)

## Recommended mods
- [Fishing Boat](https://mods.factorio.com/mod/fishing-boat)
- [Fish Finder](https://mods.factorio.com/mod/fish-finder)
- [Canal Excavator](https://mods.factorio.com/mod/canal-excavator)
- [Fishing Trawler](https://mods.factorio.com/mod/fishing-trawler)

## Compatibility
- Planet - Pelagos
- Planet - Lignumis
- Planet - Rabbasca
- Dredgeworks: Frozen Reaches (DISABLE mod setting: 'Aquilo ocean destroys items' - or importing fish will not be possible)