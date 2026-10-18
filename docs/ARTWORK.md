# Essentials artwork

## Current mod icon — 0.19.2

The user requested an icon containing only the thumbnail's subject item, without
text or background fill. Built-in imagegen extracted the backpack, retaining its
map, straps and buckles and omitting the loose keys/watch. The generated cutout
has true RGBA transparency; no colored tile or checkerboard is baked in.

- Full-resolution master: `artwork/B47ANCEDEssentials-icon.png` (1254 x 1254).
- Larger export: `artwork/B47ANCEDEssentials-icon-128.png` (128 x 128).
- Game icon: `Contents/mods/B47ANCEDEssentials/42/icon.png` (32 x 32, same slot size).

Exports preserve alpha using Windows System.Drawing SourceCopy with high-quality
bicubic resampling. The thumbnail/poster are unchanged, and the previous icon is
retained in Git history. See [ICON_0.19.2.md](ICON_0.19.2.md) for hashes, prompt,
validation and evidence limits. Publication remains paused.

## Current Workshop thumbnail — 0.19.1

On 2026-10-17 the user supplied the backpack, keys and watch artwork and requested
it as the new thumbnail. `artwork/B47ANCEDEssentials-thumbnail.png` preserves the
exact supplied 1254 x 1254 PNG. `preview.png` is its 512 x 512 high-quality bicubic
export through Windows System.Drawing. No AI generation, redraw, crop or title
edit was applied to this supplied artwork. Its source SHA-256 is
`5ea324fbc60e136d4220b9c95ac23461191fad2e6c3e04d623cb73dc1ba42747`.

The 0.19.1 request replaced only the Workshop thumbnail role. The mod poster,
`Contents/mods/B47ANCEDEssentials/thumbnail.png`, its existing authoring master
`artwork/B47ANCEDEssentials.png`, and the runtime icon were unchanged by that patch. The previous
Workshop preview remains available in Git history. No Workshop upload occurred.

See [THUMBNAIL_0.19.1.md](THUMBNAIL_0.19.1.md) for structural and visual validation.

## Historical rename artwork — 0.19.0

The existing custom artwork contained the old project name. The built-in
imagegen tool edited its title for the project rename. The scene, palette and
wrench badge were retained visually; the generated edit is not a pixel-identical
background copy. Original files remain in the private local pre-rename backup.

- Generation master: `artwork/B47ANCEDEssentials.png` (1254 x 1254 RGB PNG).
- Previous Workshop preview: `preview.png` at commit `0524741` (512 x 512 PNG).
- Current mod poster: `Contents/mods/B47ANCEDEssentials/thumbnail.png` (512 x 512 export).
- Previous runtime icon: `Contents/mods/B47ANCEDEssentials/42/icon.png` in the 0.19.0/0.19.1 source history.

The 512 px exports use deterministic high-quality bicubic scaling through
Windows System.Drawing. No default branding assets were regenerated or replaced.
The live Workshop item has not been updated.

Historical imagegen prompt (poster title edit, not the supplied 0.19.1 thumbnail):

> Use case: text-localization. Edit target: the supplied existing square Project Zomboid mod Workshop thumbnail. Replace ONLY the bottom title 'itJustWorks' with exact text "B47ANCE'd Essentials". Use two lines if needed: smaller "B47ANCE'd" above large "Essentials". Preserve the worn industrial block typography, cream and amber lettering, dark outline and the yellow/black underline. Keep all remaining artwork visually unchanged: isometric survival workshop/kitchen, seated person, shelves, lighting, zombies outside window, top-right hexagonal wrench badge, composition, palette, square framing. Do not add anything else and do not retain any old title text. Text must be spelled exactly B47ANCE'd Essentials. This is a title replacement for the same project's rename, not a new artwork concept. Opaque background. Output a square PNG.
