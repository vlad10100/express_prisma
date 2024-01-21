import { PrismaClient } from "@prisma/client";

declare global {
  namespace NodeJs {
    interface global {}
  }
}

interface CustomNodeJsGlobal extends NodeJs.global {
  prisma: PrismaClient;
}

declare const global: CustomNodeJsGlobal;

// Ensures that a single instance of PrismaClient is used.
const prisma = global.prisma || new PrismaClient();

if (process.env.NODE_ENV === "development") {
  global.prisma = prisma;
}

export default prisma;
