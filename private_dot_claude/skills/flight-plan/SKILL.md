---
name: flight-plan
description: Write a technical build plan or engineering brief as an Artifact in the hangarbay house style — architecture diagram, event/mapping table, sequenced phases, and an honest hazard list. Use when the user asks for a build plan, project plan, roadmap, technical brief, design doc, RFC, or "how would we build X", especially for hangarbay projects. Also use when asked for a plan "like the flight plan" or "in the usual style".
---

# Flight Plan — technical briefs in the hangarbay house style

Produces a single-page HTML Artifact: a build plan an engineer can act on, with the
riskiest unknown named and sequenced first.

## Before writing

**Research before you plan.** A plan built on recalled API surfaces is worthless.
Verify the protocol/SDK/CLI surface you're planning against — WebFetch the real docs,
download the real schema, run `--help`. State version numbers and counts you actually
observed. If something can't be verified, it becomes a phase-01 spike, not a confident
assertion.

**Find the riskiest unknown.** Every plan has one thing that, if it doesn't work,
invalidates the rest. Name it explicitly, put a timeboxed spike for it in the first two
phases, and say what the fallback is. This is the single most valuable thing the document
does — a plan that sequences comfortable work first is a bad plan.

## Structure

Sections in this order. Drop any that would be padding; never add a section to fill space.

| Section | Content | Notes |
|---|---|---|
| Masthead | Org mark, project number, title, one-paragraph thesis | Thesis says what you build **and what you deliberately don't** |
| Lede | 2–3 sentences of context | What the reader needs before the diagram |
| Architecture | Inline SVG + one-line caption | The real mechanism, not boxes labelled with nouns |
| The build | What the thing is, framed by the key reframe | Lead with the distinction that changes the size of the work |
| Substance table | The actual mapping/API/schema detail | The part that proves the plan is real work, not vibes |
| Spike this first | The riskiest unknown, options ranked, timebox | Use the `.note` callout |
| Phases | Numbered, each with a one-line rationale | Mark which phases **ship** with `.ship` |
| Hazards | Severity + name + consequence | Include legal, competitive, and schedule — not just technical |
| Repos / components | Name, role, one line | Say which attracts contributors and which earns money |
| Footer | What was verified, against what, when — and what wasn't | Non-negotiable. See below |

## Editorial rules

- **Numbered phases are a real sequence.** Each phase's number must mean "after the one
  before." If order doesn't matter, use an unnumbered list.
- **Hazards must be able to hurt.** "Scope might grow" is filler. Name the specific
  mechanism, who it blocks, and what you'd do instead. Include non-technical hazards —
  licensing, terms of service, someone already building it.
- **Mark what ships.** A phase list with no releases in it is a waterfall. At least one
  early phase should produce something usable by someone other than the author.
- **Footer states provenance.** What was verified, against which source, on what date, and
  explicitly which assumptions remain unproven. This is what separates a brief from a pitch.
- **Prefer the honest smaller number.** If the simpler path is genuinely enough, say so in
  the document rather than justifying the complicated one.

## Visual system

Copy `reference/house-style.css` into a `<style>` block, and the Google Fonts `<link>`
noted at the top of that file into the head. Do not restyle it per document — the point is
that these briefs are recognizably one series.

- **Type** — Saira Condensed 700 for display (aircraft-placard register, uppercase),
  IBM Plex Sans for body, IBM Plex Mono for labels, code, and table headers.
- **Color** — slate-blue neutrals with a deck-amber accent (`#FFB000` dark / `#9A6200`
  light, darkened for contrast). Full light/dark token sets are defined; don't add colors
  outside them except semantic severity, which is already there (`--ok`, `--warn`, `--crit`).
- **Masthead** — always the dark deck ground with the amber bottom rule, regardless of theme.
- **Not cards.** Rows separated by hairlines. Reserve borders and fills for the one callout
  that needs lifting.

Class names available: `.mast` `.org` `.thesis` `.eyebrow` `.lede` `.scroll` `.phases`
`.phase` `.phase-n` `.ship` `.hazard` `.sev.high|.med|.low` `.note` `.bay` `.bay-name`.
Wrap every table and SVG in `.scroll`.

## Diagram

Hand-author inline SVG; don't load a library. It must show the real mechanism — what flows
where, over what protocol, and what each box owns. Label the edges with actual method or
message names from the system being described. Use `var(--ink)`, `var(--surface)`,
`var(--rule)`, `var(--accent)` so it works in both themes, give every shape an explicit
fill, and leave viewBox room for the outermost labels.

## Publishing

Title is the project name plus the document type where that reads as one name
("Hangarbay Flight Plan"), never a title with an appended explainer. Favicon 🛩️ for
hangarbay work. Put the one-sentence summary in the publish `description`, not the title.
