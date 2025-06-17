# Dockerfile for Next.js app in a pnpm monorepo
# This Dockerfile should be built from the root of the monorepo:
# > docker build -t iris-ssr .
# > docker run -p 3000:3000 iris-ssr

# -----------------
# Base stage
# -----------------
FROM node:20-alpine AS base
WORKDIR /app
RUN corepack enable

# -----------------
# Builder stage
# -----------------
FROM base AS builder

RUN apk update && apk add --no-cache git perl

RUN git clone https://github.com/Afilmory/Afilmory --depth 1 .
COPY config.json ./
COPY builder.config.json ./
COPY .env ./

RUN sh ./scripts/preinstall.sh
# Install all dependencies
RUN pnpm install --frozen-lockfile

# Build the app.
# The build script in the ssr package.json handles building the web app first.
RUN pnpm --filter=@afilmory/ssr build

# -----------------
# Runner stage
# -----------------
FROM base AS runner

WORKDIR /app

ENV NODE_ENV=production
# ENV PORT and other configurations are now in the config files
# and passed through environment variables during runtime.
RUN apk add --no-cache curl wget
# Create a non-root user
RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

USER nextjs

COPY --from=builder --chown=nextjs:nodejs /app/apps/ssr/.next/standalone ./
COPY --from=builder --chown=nextjs:nodejs /app/apps/ssr/.next/static /app/apps/ssr/.next/static
COPY --from=builder --chown=nextjs:nodejs /app/apps/ssr/public /app/apps/ssr/public

# The standalone output includes the server.js file.
# The PORT environment variable is automatically used by Next.js.
EXPOSE 3000

CMD ["node", "apps/ssr/server.js"]
