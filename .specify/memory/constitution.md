# Protos Constitution

## Core Principles

### I. Contracts Live in This Repo
This repository owns the gRPC wire contracts as `.proto` source under `src/`. Specs describe ownership, compatibility expectations, and regeneration behavior. Specs MUST link to `src/*.proto` and MUST NOT paste message fields, RPC signatures, or enum value lists.

### II. Specs Describe Behavior, Not Invented Reality
Baseline and feature specs document current or agreed intended behavior. Do not invent features and call them current. Desired changes are Spec Kit features, not silent edits to baseline requirements.

### III. Generated Stubs Are Downstream
Language stubs under `proto/` are generated from `src/`. Contract changes start here, then propagate to consumers (server, Orchestra commands, studio-v3, SDKs, frontend, RL trainers) only after impact-check and explicit confirmation.

### IV. Numeric Match Constants Are Not Here
Match numeric constants live in `lugo4go/specs/specs.go`. Do not redefine those values in protos specs or Markdown. Link that file when a change depends on them.

### V. Game Rules Stay External
Human-readable game rules live at https://spec.lugobots.ai/. Link that site. Do not copy or replace its content in this Spec Kit project.

## Platform Coordination

Lugo Blueprint (`lugo-blueprint`) is the platform index and dependency graph (`services.yaml`), not the source of truth for requirements.

During `/speckit-plan` (or equivalent plan skill), run the Blueprint `impact-check` skill. Alert direct dependents. Do not edit other repos until a person confirms which Spec Kit projects to open. Do not create a central multi-repo `tasks.md` in Blueprint.

OpenSpec under Blueprint is frozen archive. New work belongs in this Spec Kit project.

## Development Workflow

1. `/speckit-specify` in this repo for contract or proto-ownership changes.
2. `/speckit-plan` with Blueprint impact-check before implementation.
3. Implement and regenerate stubs with the repo's documented Docker/proto-gen flow.
4. Propagate only to confirmed dependent projects.

## Governance

This constitution governs Spec Kit planning and implementation in `protos`. Amendments require updating this file with a version bump and date. All PRs that change specs or contracts should respect these principles. Complexity and breaking wire changes must be justified and called out in the feature plan.

**Version**: 1.0.0 | **Ratified**: 2026-11-05 | **Last Amended**: 2026-11-05
