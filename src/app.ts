import express from "express";
import dotenv from "dotenv";
import cors from "cors";
import bodyparser from "body-parser";
import prisma from "./utils/prisma-client";

import morganMiddleware from "./middlewares/morgan.middleware";
import Logger from "./utils/logger";


/**
 * App Configuration
 */
dotenv.config();
const app: express.Application = express();
app.use(cors());
app.use(bodyparser.json());
app.use(bodyparser.urlencoded({ extended: true }));

/**
 * PORT
 */
const port = process.env.PORT;

/**
 * LOGGING
 */
app.use(morganMiddleware)

/**
 * TEST ROUTE
 */
app.use("/vlad", (req, res) => {
  Logger.info("SAMPLE QUERY");
  const data = {
    name: "vlad",
    age: 25,
  };
  res.status(200).json(data);
});

app.use("/query", async (req, res) => {
  const activeCustomers = await prisma.activeCustomer.findMany();
  res.status(200).json(activeCustomers);
});

app.listen(port, () => {
  console.log(`Server is running at port ${port}`);
});

export default app;
