import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { Logger } from 'nestjs-pino';

async function bootstrap() {
  const app = await NestFactory.create(AppModule, { bufferLogs: true });
  app.useLogger(app.get(Logger));
  app.setGlobalPrefix('/cp/temp/app/api');
  await app.listen(process.env.PORT ?? 3000);
}

void (async (): Promise<void> => {
  try {
    await bootstrap();
  } catch (error) {
    console.error(error);
  }
})();
