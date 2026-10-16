# Hermes AI Agent — Autonomous Wealth Engine · Status Dashboard

Live, auto-generated status page for an autonomous local agent engine:

**https://m4ozpaul01.github.io/hermes-wealth-engine-dashboard/**

## What this is

A single self-contained static HTML page, regenerated from a live local ledger.
It reports:

- **Telemetry** — host class, budget meter, knowledge-base growth
- **Quant & Congress** — US House STOCK Act (Periodic Transaction Report) signal
  detection, plus prediction-market whale flow derived from public trade data
- **Agent squads** — the roster with fitness scores and self-evolution versions
- **Proposals** — strategies awaiting a human decision

## Honest status

**Real revenue: EUR 0.00.** The engine runs fully autonomously *locally* —
self-scheduled, self-audited, zero cloud-token spend — but it holds no
brokerage, exchange, payment-processor or hosting credentials. Division 2 is a
**simulated paper ledger**; every fill deducts commission, spread, slippage and
gas, and no real order is ever placed. Every revenue channel it designs
terminates in a step only a verified human can complete.

## Data provenance

- **Congress transactions** — public-record STOCK Act filings published by the
  Clerk of the House. The engine indexes the filing directory and parses the
  transaction tables from the disclosure PDFs.
- **Market data** — keyless public quote APIs.
- **Paper trades** — simulated, not real.
- **Prediction markets** — public trade flow.

## What is deliberately NOT published

This page is generated from an internal status build by
`CORE/gh_pages.py`, which strips before writing:

- the operator's email addresses
- the machine hostname
- absolute filesystem paths
- credential and SMTP configuration state
- full risk assessments of pending proposals

An automated audit (`CORE.gh_pages.audit_published_page`) fails the build if an
email address, absolute path or local hostname reaches the output.

## Detection rules

- **Cluster Rule** — 3+ members transacting the same asset inside a 14-day window
- **Committee Alignment Filter** — each trade cross-referenced against the
  member's committee assignments

A detected cluster only triggers research into *why* the trade happened. It is
never treated as a recommendation, and nothing here is investment advice.
