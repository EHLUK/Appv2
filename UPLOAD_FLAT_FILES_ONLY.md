# Planningappv10 Flat Upload

This package is designed for GitHub web upload where folders keep getting missed.

Upload every file in this folder directly into the root of `EHLUK/Planningappv10`.

Do not upload the folder itself.
Do not upload the ZIP itself.

After upload, these root files must exist in GitHub:

- `Dockerfile`
- `package.json`
- `app-page.tsx`
- `app-layout.tsx`
- `app-globals.css`
- `control-hub-app.tsx`
- `xer.ts`
- `types.ts`
- `sample-data.ts`
- `app-modules.ts`
- `prisma-lib.ts`
- `schema.prisma`
- `exentec-hargreaves-logo.png`

The Dockerfile will rebuild the correct folders during Render build:

- `app/`
- `src/components/`
- `src/lib/`
- `prisma/`
- `public/`
