# Stage 1: Builder
FROM 877502627026.dkr.ecr.ap-southeast-7.amazonaws.com/miniapps-template-nestjs:baseimage-latest AS builder


WORKDIR /usr/src/app

# Copy app source
ADD ./source .

# Build source
RUN npm run build

# Remove devDependencies
RUN npm prune --prod

# Stage 2: Final runtime
FROM node:22.14-alpine AS final

ENV TZ=Asia/Bangkok

# Set timezone (minimal)
RUN apk add --no-cache tzdata \
    && cp /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone \
    && apk del tzdata \
    && rm -rf /var/cache/apk/*

WORKDIR /app

# Create a non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Copy runtime artifacts
COPY --from=builder /usr/src/app/package.json ./
COPY --from=builder /usr/src/app/node_modules ./node_modules
COPY --from=builder /usr/src/app/dist ./dist

# Set ownership to non-root user
RUN chown -R appuser:appgroup /app

# Switch to non-root user
USER appuser

EXPOSE 3000

# Run directly
CMD ["node", "dist/main"]
