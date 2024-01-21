-- CreateEnum
CREATE TYPE "JobType" AS ENUM ('OXYLABS', 'LOCAL');

-- CreateTable
CREATE TABLE "ActiveCustomer" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "customerId" INTEGER NOT NULL,

    CONSTRAINT "ActiveCustomer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CustomerSite" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "siteUrl" TEXT NOT NULL,
    "activeCustomerId" INTEGER,

    CONSTRAINT "CustomerSite_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CollectionJob" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "name" TEXT NOT NULL,
    "isInitialized" BOOLEAN NOT NULL DEFAULT false,
    "jobType" "JobType" NOT NULL DEFAULT 'OXYLABS',
    "jobKey" TEXT,
    "keyword" TEXT NOT NULL,
    "geoLocation" TEXT NOT NULL,
    "domain" TEXT NOT NULL,
    "activeCustomerId" INTEGER,
    "oxylabsScheduleId" INTEGER,

    CONSTRAINT "CollectionJob_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "QueryResult" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "query" TEXT NOT NULL,
    "geoLocation" TEXT NOT NULL,
    "domain" TEXT NOT NULL,
    "isProcessed" BOOLEAN NOT NULL DEFAULT false,
    "paidResults" JSONB NOT NULL DEFAULT '{}',
    "organicResults" JSONB NOT NULL DEFAULT '{}',
    "collectionJobId" INTEGER,

    CONSTRAINT "QueryResult_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "KeywordStatus" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "query" TEXT NOT NULL,
    "geoLocation" TEXT NOT NULL,
    "domain" TEXT NOT NULL,
    "queryTimestamp" TIMESTAMP(3) NOT NULL,
    "collectionJobId" INTEGER,

    CONSTRAINT "KeywordStatus_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PaidResult" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "position" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "url" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "data" TEXT NOT NULL,
    "keywordStatusId" INTEGER,

    CONSTRAINT "PaidResult_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "OrganicResult" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "position" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "url" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "data" TEXT NOT NULL,
    "keywordStatusId" INTEGER,

    CONSTRAINT "OrganicResult_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "OxylabsJob" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "jobId" TEXT NOT NULL,
    "scheduleId" TEXT NOT NULL,

    CONSTRAINT "OxylabsJob_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "OxylabsSchedule" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "expiresAt" TIMESTAMP(3),
    "externalScheduleId" INTEGER,
    "storageType" TEXT,
    "storageUrl" TEXT,
    "source" TEXT,
    "domain" TEXT,
    "userAgent" TEXT,
    "cron" TEXT,

    CONSTRAINT "OxylabsSchedule_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Query" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "oxylabsScheduleId" INTEGER,

    CONSTRAINT "Query_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GeoLocation" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "location" TEXT NOT NULL,
    "oxylabsScheduleId" INTEGER,

    CONSTRAINT "GeoLocation_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "ActiveCustomer_customerId_key" ON "ActiveCustomer"("customerId");

-- CreateIndex
CREATE UNIQUE INDEX "CollectionJob_oxylabsScheduleId_key" ON "CollectionJob"("oxylabsScheduleId");

-- CreateIndex
CREATE INDEX "createdAt" ON "QueryResult"("createdAt");

-- CreateIndex
CREATE INDEX "isProcessed" ON "QueryResult"("isProcessed");

-- CreateIndex
CREATE INDEX "queryTimestamp" ON "KeywordStatus"("queryTimestamp");

-- CreateIndex
CREATE INDEX "collectionJobId" ON "KeywordStatus"("collectionJobId");

-- CreateIndex
CREATE UNIQUE INDEX "OxylabsJob_jobId_key" ON "OxylabsJob"("jobId");

-- CreateIndex
CREATE INDEX "jobId" ON "OxylabsJob"("jobId");

-- AddForeignKey
ALTER TABLE "CustomerSite" ADD CONSTRAINT "CustomerSite_activeCustomerId_fkey" FOREIGN KEY ("activeCustomerId") REFERENCES "ActiveCustomer"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CollectionJob" ADD CONSTRAINT "CollectionJob_activeCustomerId_fkey" FOREIGN KEY ("activeCustomerId") REFERENCES "ActiveCustomer"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CollectionJob" ADD CONSTRAINT "CollectionJob_oxylabsScheduleId_fkey" FOREIGN KEY ("oxylabsScheduleId") REFERENCES "OxylabsSchedule"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "QueryResult" ADD CONSTRAINT "QueryResult_collectionJobId_fkey" FOREIGN KEY ("collectionJobId") REFERENCES "CollectionJob"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "KeywordStatus" ADD CONSTRAINT "KeywordStatus_collectionJobId_fkey" FOREIGN KEY ("collectionJobId") REFERENCES "CollectionJob"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PaidResult" ADD CONSTRAINT "PaidResult_keywordStatusId_fkey" FOREIGN KEY ("keywordStatusId") REFERENCES "KeywordStatus"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OrganicResult" ADD CONSTRAINT "OrganicResult_keywordStatusId_fkey" FOREIGN KEY ("keywordStatusId") REFERENCES "KeywordStatus"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Query" ADD CONSTRAINT "Query_oxylabsScheduleId_fkey" FOREIGN KEY ("oxylabsScheduleId") REFERENCES "OxylabsSchedule"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GeoLocation" ADD CONSTRAINT "GeoLocation_oxylabsScheduleId_fkey" FOREIGN KEY ("oxylabsScheduleId") REFERENCES "OxylabsSchedule"("id") ON DELETE SET NULL ON UPDATE CASCADE;
