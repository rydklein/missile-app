/*
  Warnings:

  - You are about to drop the column `gameId` on the `Object` table. All the data in the column will be lost.
  - You are about to drop the column `gameId` on the `User` table. All the data in the column will be lost.
  - You are about to drop the `Game` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Object" DROP CONSTRAINT "Object_gameId_fkey";

-- DropForeignKey
ALTER TABLE "User" DROP CONSTRAINT "User_gameId_fkey";

-- AlterTable
ALTER TABLE "Object" DROP COLUMN "gameId";

-- AlterTable
ALTER TABLE "User" DROP COLUMN "gameId";

-- DropTable
DROP TABLE "Game";
