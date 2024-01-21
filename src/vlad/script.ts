import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

const main = async () => {
  try {
    /**
     * CREATE SINGLE USER
     */
    // const user = await prisma.user.create({
    //   data: {
    //     name: "VLAD1",
    //     email: "vlad1@prisma.io",
    //   },
    // });
    // console.log(user);
    /**
     * GET ALL USERS
     */
    // const users = await prisma.user.findMany();
    // console.log(users);
    /**
     * GET SPECIFIC USER
     */
    // const user = await prisma.user.findFirst({ where: { name: "VLAD1" } });
    // console.log(user);
    /**
     * CREATE USER WITH RELATION TO POST
     */
    // const user = await prisma.user.create({
    //   data: {
    //     name: "vlad2",
    //     email: "vlad2@prisma.io",
    //     posts: {
    //       create: {
    //         title: "HELLO WORLD",
    //       },
    //     },
    //   },
    // });
    // console.log(user);
    /**
     * GET USERS WITH POST
     */
    // const userWithPosts = await prisma.user.findMany({
    //   include: {
    //     posts: true,
    //   },
    // });
    // console.dir(userWithPosts, { depth: null });
  } catch (error) {
    console.log(error);
    process.exit(1);
  } finally {
    await prisma.$disconnect();
  }
};

main();
