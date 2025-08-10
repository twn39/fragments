FROM node:22-alpine AS builder

# 设置工作目录
WORKDIR /app

COPY package*.json ./

RUN npm install --frozen-lockfile

COPY . .

RUN npm run build

FROM node:22-alpine AS runner

WORKDIR /app

RUN addgroup -S nextjs && adduser -S nextjs -G nextjs
USER nextjs

COPY --from=builder --chown=nextjs:nextjs /app/.next/ ./.next/
COPY --from=builder --chown=nextjs:nextjs /app/public ./public
COPY --from=builder --chown=nextjs:nextjs /app/package.json /app/next.config.mjs ./

EXPOSE 3000

ENV NODE_ENV=production
ENV PORT=3000

CMD [ "npm", "run", "start" ]
