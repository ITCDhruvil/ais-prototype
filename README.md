# AIS prototype

One self-contained HTML file (`index.html`): vanilla JS and CSS, no build step, no framework. The state of each user lives in their own browser (localStorage). Sign-in is simulated with seeded personas, so there is nothing secret in it.

This folder is meant to live in **its own repository**, separate from the Negotiation Desk. People who work on the UI only touch this repository; the Desk stays deployed as it is.

## Two ways to run it

**1. On its own (default, safest).** Open `index.html` in a browser, or serve the folder with `python -m http.server 8765`. With no Desk address set, AIS never calls the Desk. A request that reaches the negotiation step runs the internal simulation, so the whole flow can be analysed and changed without any backend.

**2. Connected to the deployed Negotiation Desk.** The Desk addresses are two `<meta>` tags at the top of `index.html`:

```html
<meta name="negdesk-api" content="https://negotiation-api.onrender.com">
<meta name="negdesk-web" content="https://negotiation-web.onrender.com">
```

On Render these are filled in by the build command from the environment variables `NEGDESK_API` and `NEGDESK_WEB`. Opened from `localhost` with no tags set, AIS looks for the Desk on `http://localhost:8000` (API) and `http://localhost:3000` (web).

## What AIS sends to the Desk, and what that means for UI work

With the addresses set, AIS **writes to the Desk**: it creates an event per negotiation, uploads files, and approves the deal. These are real calls to a shared service, so:

- Work against the simulation (option 1) unless you need the Desk. Most UI work does not.
- Use the Desk link only for testing the integration, and expect test events (`CMP-...`) to pile up there. The Desk owner can clear them.
- Never add keys, passwords or tokens to this file; the Desk needs none.

## Deploy on Render

1. Create a new Render Blueprint from this repository (it reads `render.yaml`) or a Static Site with build command `sed -i "s|__NEGDESK_API__|${NEGDESK_API}|g; s|__NEGDESK_WEB__|${NEGDESK_WEB}|g" index.html` and publish directory `.`.
2. Set `NEGDESK_API` and `NEGDESK_WEB` (or leave them empty to deploy the simulation only), then deploy.
3. **One setting on the Desk, by its owner:** add the AIS address to `NEGOTIATION_CORS_ORIGINS` on the Desk API (comma separated with the existing value). Without it the browser blocks AIS from calling the Desk. For local work against the deployed Desk, the owner also adds `http://localhost:8765`.

## Where to look in the file

| What | Search for |
|---|---|
| The Desk link (adapter, polling, result, files, contract) | `NegDesk` |
| Step 30 Shopping Cart list and "create a cart" | `scCombo`, `SCN` |
| Step 31 supplier list and offers | `supCombo`, `ws31` |
| Contract Registry page details | `crDeskHTML` |
| Placeholders for number fields | `NumHints` |
