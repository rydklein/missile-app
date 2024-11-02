/*
  Warnings:

  - You are about to drop the column `name` on the `Object` table. All the data in the column will be lost.
  - You are about to drop the `_GameObjects` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_UserGames` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `gameId` to the `Object` table without a default value. This is not possible if the table is not empty.
  - Added the required column `lat` to the `Object` table without a default value. This is not possible if the table is not empty.
  - Added the required column `long` to the `Object` table without a default value. This is not possible if the table is not empty.
  - Added the required column `type` to the `Object` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "_GameObjects" DROP CONSTRAINT "_GameObjects_A_fkey";

-- DropForeignKey
ALTER TABLE "_GameObjects" DROP CONSTRAINT "_GameObjects_B_fkey";

-- DropForeignKey
ALTER TABLE "_UserGames" DROP CONSTRAINT "_UserGames_A_fkey";

-- DropForeignKey
ALTER TABLE "_UserGames" DROP CONSTRAINT "_UserGames_B_fkey";

-- AlterTable
ALTER TABLE "Object" DROP COLUMN "name",
ADD COLUMN     "gameId" INTEGER NOT NULL,
ADD COLUMN     "lat" DOUBLE PRECISION NOT NULL,
ADD COLUMN     "long" DOUBLE PRECISION NOT NULL,
ADD COLUMN     "type" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "User" ADD COLUMN     "gameId" INTEGER;

-- DropTable
DROP TABLE "_GameObjects";

-- DropTable
DROP TABLE "_UserGames";

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_gameId_fkey" FOREIGN KEY ("gameId") REFERENCES "Game"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Object" ADD CONSTRAINT "Object_gameId_fkey" FOREIGN KEY ("gameId") REFERENCES "Game"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
