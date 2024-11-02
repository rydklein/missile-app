-- CreateTable
CREATE TABLE "User" (
    "id" SERIAL NOT NULL,
    "device_token" TEXT NOT NULL,
    "name" TEXT,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_device_token_key" ON "User"("device_token");
