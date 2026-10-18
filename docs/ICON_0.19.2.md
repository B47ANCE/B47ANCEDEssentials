# Transparent icon — 0.19.2, 2026-10-18

The user requested an icon derived from the current thumbnail, containing only
the subject item without text or background fill. The central backpack was
selected, including its map, straps, handle and buckles. Loose keys/watch, text,
backdrop and floor shadow are omitted. This compatible artwork PATCH changes no
gameplay/API/configuration; only the TestKit diagnostic version changes in Lua.

Built-in imagegen performed the cutout. Exports use Windows System.Drawing
high-quality bicubic resampling with SourceCopy into 32-bit ARGB bitmaps. No
default branding assets were used. Prior artwork remains in Git history.

| Asset | Dimensions | SHA-256 |
| --- | --- | --- |
| `artwork/B47ANCEDEssentials-icon.png` | 1254 x 1254 | `093b8cc45b406f3f04a326c95f96ff753a93bf79734a0058a0f4c510743b7d32` |
| `artwork/B47ANCEDEssentials-icon-128.png` | 128 x 128 | `25b539cee6fbf9dea00a979bddff58d61ee1f67deb8ca920bc567d43330faaea` |
| `Contents/mods/B47ANCEDEssentials/42/icon.png` | 32 x 32 | `b6bb2543a44296e19059d981b5a9d10b17e8523c59f2099f3f6fd4892ba2da2f` |

[TESTED — offline] Master decodes as 32-bit ARGB, with all four corner alpha
values zero. The 32 px export has 362 fully transparent and 662 visible pixels;
the 128 px export has 6521 transparent and 9863 visible pixels. The existing
runtime slot was 32 x 32 and retains that size. Visual inspection confirms only
the backpack/map subject, with no text, loose objects or background tile. Image
generation preserves the source design visually, not as a pixel-identical crop.

Validation commands from the project root:

```powershell
.\.venv\Scripts\python.exe scripts/check_versions.py
.\.venv\Scripts\python.exe scripts/check_identity.py
Get-FileHash -LiteralPath artwork\B47ANCEDEssentials-icon.png,artwork\B47ANCEDEssentials-icon-128.png,Contents\mods\B47ANCEDEssentials\42\icon.png -Algorithm SHA256
git diff --cached --check
```

Source/asset byte comparisons must verify that the thumbnail/poster, masters,
historical package and prepared 0.19.1 upload are unchanged. No new gameplay
regression suite is needed for this image-only patch; prior host results remain
tied to their original source. Native display is NOT TESTED. Existing dedicated
G7 and stable-release G8 remain BLOCKED. No package, deployment, upload or Steam
restart is performed, and the user's paused-publication instruction remains active.

Exact built-in imagegen prompt:

> Use case: background-extraction / precise-object-edit. Edit target: supplied Essentials thumbnail. Create an icon containing ONLY the central olive-green canvas backpack, including its brown leather straps, metal buckles, handle, side pockets and the folded map tucked into its opening. Preserve the existing backpack's design, three-quarter view, colors, shading and chunky pixel-art texture. Extract this subject faithfully; do not redesign it. REMOVE all lettering (B47ANCE'd and ESSENTIALS), the loose key ring/keys and the wristwatch. Remove the entire dark backdrop and any floor shadow, halo, vignette, square plate or colored background fill. The outside of the backpack must be genuine fully transparent alpha, not black/white or a checkerboard painted into the image. Center the complete backpack on a square transparent PNG canvas, large enough to read as a small game mod icon, with about 6% transparent margin and no clipping of its straps or handle. No extra objects, no text, no border. Desired output 1024 by 1024 pixels, opaque detailed backpack with clean silhouette and true transparency outside.
