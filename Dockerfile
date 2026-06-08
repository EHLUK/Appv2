FROM node:20-alpine AS deps

WORKDIR /app
COPY package*.json ./
RUN npm install

FROM node:20-alpine AS builder

WORKDIR /app
RUN apk add --no-cache openssl
COPY --from=deps /app/node_modules ./node_modules
COPY . .

# Rebuild the Next/Prisma folder structure from flat files uploaded at repo root.
RUN mkdir -p app src/components src/lib prisma public
RUN cp app-page.tsx app/page.tsx
RUN cp app-layout.tsx app/layout.tsx
RUN cp app-globals.css app/globals.css
RUN cp control-hub-app.tsx src/components/control-hub-app.tsx
RUN cp xer.ts src/lib/xer.ts
RUN cp types.ts src/lib/types.ts
RUN cp sample-data.ts src/lib/sample-data.ts
RUN cp app-modules.ts src/lib/app-modules.ts
RUN cp prisma-lib.ts src/lib/prisma.ts
RUN cp schema.prisma prisma/schema.prisma
RUN cp exentec-hargreaves-logo.png public/exentec-hargreaves-logo.png

RUN npx prisma generate --schema=./prisma/schema.prisma
RUN npm run build

FROM node:20-alpine AS runner

WORKDIR /app
RUN apk add --no-cache openssl
ENV NODE_ENV=production
ENV PORT=3000

COPY --from=builder /app ./

EXPOSE 3000
CMD ["npm", "run", "start"]
