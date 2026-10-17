# Essentials title artwork

The existing custom artwork contained the old project name. The built-in
imagegen tool edited its title for the project rename. The scene, palette and
wrench badge were retained visually; the generated edit is not a pixel-identical
background copy. Original files remain in the private local pre-rename backup.

- Generation master: `artwork/B47ANCEDEssentials.png` (1254 x 1254 RGB PNG).
- Workshop preview: `preview.png` (512 x 512 PNG).
- Mod poster: `Contents/mods/B47ANCEDEssentials/thumbnail.png` (identical 512 x 512 export).
- Runtime icon: `Contents/mods/B47ANCEDEssentials/42/icon.png` (unchanged original).

The 512 px exports use deterministic high-quality bicubic scaling through
Windows System.Drawing. No default branding assets were regenerated or replaced.
The live Workshop item has not been updated.

Exact imagegen prompt:

> Use case: text-localization. Edit target: the supplied existing square Project Zomboid mod Workshop thumbnail. Replace ONLY the bottom title 'itJustWorks' with exact text "B47ANCE'd Essentials". Use two lines if needed: smaller "B47ANCE'd" above large "Essentials". Preserve the worn industrial block typography, cream and amber lettering, dark outline and the yellow/black underline. Keep all remaining artwork visually unchanged: isometric survival workshop/kitchen, seated person, shelves, lighting, zombies outside window, top-right hexagonal wrench badge, composition, palette, square framing. Do not add anything else and do not retain any old title text. Text must be spelled exactly B47ANCE'd Essentials. This is a title replacement for the same project's rename, not a new artwork concept. Opaque background. Output a square PNG.
