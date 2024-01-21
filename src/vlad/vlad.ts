import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

const main = async () => {
  try {
    // const subject = await prisma.subject.create({
    //   data: {
    //     name: "Physics",
    //     description: "Introduction to Physics",
    //     active: false,
    //   },
    // });
    // console.log(subject);
    //
    // const subjects = await prisma.subject.findUnique({
    //   where: { id: 1 },
    // });
    // console.dir(subjects, { depth: null });
    //
    // const professor = await prisma.professor.create({
    //   data: {
    //     name: "Prof V",
    //   },
    // });
    // console.log(professor);
    //
    // const student = await prisma.student.create({
    //   data: {
    //     name: "young vlad 4",
    //   },
    // });
    // console.log(student);
    //
    // const students = await prisma.student.findMany();
    // const studentIds = students.map((item) => item.id);
    // const disconnect = await prisma.subject.update({
    //   where: {
    //     id: 1,
    //   },
    //   data: {
    //     students: {
    //       disconnect: studentIds.map((id) => ({ id })),
    //     },
    //   },
    // });
    //
    // const subjectToUpdate = await prisma.subject.findFirst({
    //   where: {
    //     name: "Physics",
    //   },
    // });
    //
    // if (subjectToUpdate) {
    //   const subject = await prisma.subject.update({
    //     where: {
    //       id: subjectToUpdate?.id,
    //     },
    //     data: {
    //       students: { connect: students }, // { id: students?.id }
    //     },
    //   });
    //   console.log(subject);
    // }
    //
    // const subjects = await prisma.subject.findMany({
    //   include: { students: true },
    // });
    // console.dir(subjects, { depth: null });
  } catch (error) {
    console.log(error);
    process.exit(1);
  } finally {
    await prisma.$disconnect();
  }
};

main();

// This is your Prisma schema file,
// learn more about it in the docs: https://pris.ly/d/prisma-schema

// generator client {
//   provider = "prisma-client-js"
// }

// datasource db {
//   provider = "postgresql"
//   url      = env("DATABASE_URL")
// }

// model Subject {
//   id          Int        @id @default(autoincrement())
//   createdAt   DateTime   @default(now())
//   updatedAt   DateTime   @updatedAt
//   name        String     @db.VarChar(255)
//   description String?
//   active      Boolean    @default(false)
//   professor   Professor? @relation(fields: [professorId], references: [id])
//   professorId Int?
//   students    Student[]
// }

// model Professor {
//   id        Int       @id @default(autoincrement())
//   createdAt DateTime  @default(now())
//   updatedAt DateTime  @updatedAt
//   name      String    @db.VarChar(255)
//   subjects  Subject[]
// }

// model Student {
//   createdAt DateTime  @default(now())
//   updatedAt DateTime  @updatedAt
//   id        Int       @id @default(autoincrement())
//   name      String    @db.VarChar(255)
//   subjects  Subject[]
// }
