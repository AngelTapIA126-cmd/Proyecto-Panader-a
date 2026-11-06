# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

Single-page marketing site for Panadería Tapia, a family bakery in Pixtun, Campeche, México. The whole site is one file, `panaderia-tapia.html`, with inline CSS and JS. There is no backend: orders go through WhatsApp links. All user-facing copy is in Spanish (`lang="es"`), so keep new copy in Spanish.

## Commands

There is no build step, package manager, linter, or test suite. To preview the site, open the file in a browser:

```powershell
Start-Process .\panaderia-tapia.html
```

An internet connection is required, because Tailwind, the fonts, and all images load from remote URLs.

## Architecture

`panaderia-tapia.html` has three parts:

- **`<head>`**: the Tailwind Play CDN (`cdn.tailwindcss.com`, compiled in the browser at runtime), an inline `tailwind.config` defining the brand palette and fonts, and a `<style>` block for custom components (`.card-pan`, `.btn-primary`, `.btn-secondary`, `.reveal`, etc.).
- **`<body>`**: sections separated by `====` banner comments: navbar, hero (`#inicio`), stats bar, catalog (`#catalogo`), history (`#historia`), location and hours (`#ubicacion`), CTA banner, footer, floating WhatsApp button.
- **Closing `<script>`**: navbar `.scrolled` toggle, the `IntersectionObserver` that adds `.visible` to `.reveal` elements, and closing the mobile menu on resize. The hamburger toggle itself is an inline `onclick`.

## Things that must change in more than one place

- **Brand colors** exist twice: as names in `tailwind.config` and as raw hex values throughout the `<style>` block and inline `style`/SVG attributes. Changing a color means updating both.
- **Phone number** (`529827311387`) appears in `wa.me` links, `api.whatsapp.com/send` links, a `tel:` link, and display text.
- **Nav links** are repeated in the desktop nav, the mobile menu, and the footer.
- **Founding year** (1978) appears in the hero, history, and footer, and the "+45 años" stat is derived from it by hand.
- **The WhatsApp icon** is the same inline SVG path, pasted in three places.

## Conventions

- Catalog items are hand-written `.card-pan` blocks. To add one, copy an existing card; prices are plain text. Put new product photos in `imagenes/` and reference them with a relative path (`imagenes/foto.jpg`).
- `.reveal` elements start at `opacity: 0` and depend on the closing script to appear. Stagger them with an inline `transition-delay`. `.reveal.visible` overrides `:hover` transforms on the same element, so the script removes the reveal classes from `.card-pan` after the fade-in; any other element with a hover transform needs the same treatment.
- Use palette names such as `text-terracotta` and `bg-cream` in markup rather than new hex values.

## Known issues

Found by reading the source, not by testing in a browser. Remove each entry once it is fixed.

- The map in `#ubicacion` is a stylized placeholder, not a real embed. The real location is only reachable through the Google Maps button.
- Product images are hotlinked from third-party sites (Unsplash, matadornetwork, labrujula24), so they can break without warning.
