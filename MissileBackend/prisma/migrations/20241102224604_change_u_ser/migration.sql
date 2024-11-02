/*
  Warnings:

  - Added the required column `device_identifier` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "User" ADD COLUMN     "device_identifier" TEXT NOT NULL;
