/*
  Warnings:

  - You are about to drop the `MissileRange` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "MissileRange" DROP CONSTRAINT "MissileRange_missileId_fkey";

-- DropForeignKey
ALTER TABLE "MissileRange" DROP CONSTRAINT "MissileRange_userId_fkey";

-- DropTable
DROP TABLE "MissileRange";

-- CreateTable
CREATE TABLE "ObjectRange" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "objectId" INTEGER NOT NULL,
    "inRange" BOOLEAN NOT NULL,

    CONSTRAINT "ObjectRange_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "ObjectRange_userId_objectId_key" ON "ObjectRange"("userId", "objectId");

-- AddForeignKey
ALTER TABLE "ObjectRange" ADD CONSTRAINT "ObjectRange_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ObjectRange" ADD CONSTRAINT "ObjectRange_objectId_fkey" FOREIGN KEY ("objectId") REFERENCES "Object"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
