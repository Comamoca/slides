# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a slides repository containing presentation materials, primarily using Typst for slide creation. The project includes:

- **Org-mode source files** (`org/`) - Literate programming approach with embedded Typst code
- **Generated Typst files** (`slide/`) - Compiled presentation files  
- **Shared libraries** (`lib/`) - Reusable Typst themes and color schemes
- **Nix development environment** - Reproducible build setup with custom fonts

## Build System & Commands

The project uses Nix for development environment and dependency management:

- `nix develop` - Enter development shell with all dependencies
- Build is handled through the Nix flake configuration
- Typst compilation uses custom font packages (UDEV Gothic NF, Noto Sans JP)
- Custom Typst packages cache for offline builds

### Development Environment

The development environment includes:
- `tinymist` - Typst language server
- Custom font configuration with Japanese support
- Pre-commit hooks for code quality (treefmt, ripsecrets, git-secrets)

## Architecture & Structure

### Literate Programming Workflow

The project follows a literate programming approach:
1. **Source**: Org-mode files (`*.org`) contain the presentation content with embedded Typst code blocks
2. **Tangling**: Code blocks are extracted to generate Typst files (`*.typ`) 
3. **Compilation**: Typst files are compiled to PDF slides

### Theme System

The custom presentation theme (`lib/theme.typ`) provides:
- **comamoca-theme**: Custom slide theme with progress bars and navigation dots
- **Slide types**: `slide()`, `title-slide()`, `focus-slide()`, `new-section-slide()`
- **Color scheme**: Defined in `lib/color.typ` with custom color palette (faff-pink, unnamed-blue, underwater-blue, etc.)
- **Touying integration**: Uses the Touying presentation framework

### File Organization

```
lib/                  # Reusable library components
├── slides.typ        # Main library - imports everything
├── helpers.typ       # Helper functions (center-image, icode, etc.)
├── templates.typ     # Slide templates (self-introduction-slide, etc.)
├── config.typ        # Configuration and styling functions
├── theme.typ         # Custom theme implementation
└── color.typ         # Color definitions

org/presentation-name/
├── main.org          # Source content with embedded Typst
├── images/           # Presentation images
└── main.typ          # Generated Typst file

slide/presentation-name/
├── main.typ          # Final presentation file
├── images/           # Presentation images (symlinked/copied)
└── main.pdf          # Compiled output
```

## Key Typst Syntax Patterns Used

- **Markup mode**: Standard document content
- **Code mode**: Functions and variables prefixed with `#`
- **Math mode**: Mathematical expressions with `$` delimiters
- **Custom functions**: `#center-image()`, `#sourcecode()`, `#icode()`
- **Speaker notes**: `#speaker-note[]` for presentation notes
- **Touying directives**: `#focus-slide[]`, `#title-slide[]`

## Working with Presentations

### Using the New Refactored Library Structure

The library has been refactored for better reusability:

```typst
#import "./lib/slides.typ": *

// Configure presentation with sensible defaults
#show: configure-presentation.with(
  total-slides: 9,
  primary: unnamed-blue,
  show-notes: right,
)

// Use templates for common slide patterns
#self-introduction-slide(
  "Speaker Name",
  twitter: "@username",
  image-path: "./path/to/image.png"
)

#project-overview-slide(
  "Project Name",
  "Description here...",
  features: ("Feature 1", "Feature 2", "Feature 3")
)

#code-example-slide(
  "Example Title",
  ```rust
  // Code here
  ```,
  language: "rust"
)
```

### Available Templates

- `self-introduction-slide()` - Speaker introduction with social media
- `project-overview-slide()` - Project description with features list
- `code-example-slide()` - Code examples with syntax highlighting
- `image-centered-slide()` - Image-focused slides with captions
- `comparison-slide()` - Bullet-point comparisons
- `quote-slide()` - Quotations with attribution
- `error-example-slide()` - Error message demonstrations
- `future-prospects-slide()` - Future roadmap/prospects
- `support-slide()` - Donation/support appeals
- `notice-slide()` - Important notices/warnings

### Helper Functions

- `center-image()` - Centered images with automatic path adjustment
- `icode()` - Inline code styling
- `error-message-block()` - Styled error message display
- `focus-box()` - Highlighted content boxes

### Editing Process

1. Modify the `.org` source file in `org/presentation-name/`
2. Use org-babel tangling to extract code blocks to `.typ` files
3. Import `./lib/slides.typ` for access to all templates and helpers
4. Images should be placed in the corresponding `images/` directory
5. Use relative paths from project root when referencing images

The project demonstrates a sophisticated literate programming approach to presentation creation, combining Org-mode's organizational capabilities with Typst's typesetting power and now enhanced with a modular, reusable library system.